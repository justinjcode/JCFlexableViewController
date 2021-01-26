//
//  JCCollectionFlowProxy.swift
//  JCFlexableViewController
//
//  Created by justin zhang on 2021/1/19.
//

import UIKit

class JCCollectionFlowProxy: NSObject {
    
    var collectionView: UICollectionView
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    var sectionList: [JCSectionModel] = [] {
        didSet {
            self.registerForCollectionView()
            self.collectionView.reloadData()
        }
    }
    
    func registerForCollectionView() {
        self.sectionList.forEach { (sectionModel) in
            if let header = sectionModel.header {
                self.collectionView.register(header.cellClass, forCellWithReuseIdentifier: NSStringFromClass(header.cellClass))
            }
            if let footer = sectionModel.footer {
                self.collectionView.register(footer.cellClass, forCellWithReuseIdentifier: NSStringFromClass(footer.cellClass))
            }
            sectionModel.cellList.forEach { (cellModel) in
                self.collectionView.register(cellModel.cellClass, forCellWithReuseIdentifier: NSStringFromClass(cellModel.cellClass))
            }
        }
    }
    
    func sectionModel(at section: Int) -> JCSectionModel? {
        if section < self.sectionList.count && section >= 0 {
            let sectionModel = self.sectionList[section]
            return sectionModel
        }
        return nil
    }
    
    func cellModel(at indexPath: IndexPath) -> JCCellModel? {
        if let sectionModel = self.sectionModel(at: indexPath.section) {
            if indexPath.item < sectionModel.cellList.count {
                let cellModel = sectionModel.cellList[indexPath.item]
                return cellModel
            }
        }
        return nil
    }
    
}

extension JCCollectionFlowProxy: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.sectionList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard section >= 0 && section < self.sectionList.count else {
            return 0
        }
        let sectionModel = self.sectionList[section]
        return sectionModel.cellList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cellModel = self.cellModel(at: indexPath) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(cellModel.cellClass), for: indexPath)
            
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "JCExceptionIdentifier", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        if let cellModel = self.cellModel(at: indexPath) {
            cellModel.selectCallback?(cell)
        }
    }
}


extension JCCollectionFlowProxy: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let cellModel = self.cellModel(at: indexPath) {
            return .init(width: self.collectionView.bounds.size.width, height: cellModel.height)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if let sectionModel = self.sectionModel(at: section) {
            return sectionModel.inset
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if let sectionModel = self.sectionModel(at: section) {
            return sectionModel.cellLineSpace
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if let sectionModel = self.sectionModel(at: section),
           let header = sectionModel.header {
            return .init(width: self.collectionView.bounds.size.width, height: header.height)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if let sectionModel = self.sectionModel(at: section),
           let footer = sectionModel.footer {
            return .init(width: self.collectionView.bounds.size.width, height: footer.height)
        }
        return .zero
    }
}
