//
//  JCSwipeMenuView.swift
//  JCFlexableViewController
//
//  Created by justin zhang on 2021/1/19.
//

import UIKit

class JCSwipeMenuItem: NSObject {
    var menuId: Int
    var title: String
    init(id: Int, title: String) {
        self.menuId = id
        self.title = title
    }
}

class JCSwipeMenuView: UIView {
    
    public var menuList: [JCSwipeMenuItem] = []
    
    var proxy: JCCollectionFlowProxy!
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let view = UICollectionView.init(frame: self.bounds, collectionViewLayout: layout)
        return view
    }()
    
    func setupUI() {
        self.addSubview(self.collectionView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.collectionView.frame = self.bounds
    }
    
    func reloadMenus(_ menuList: [JCSwipeMenuItem]) {
        self.menuList = menuList
        self.configData()
    }
    
    public func configData() {
        
        self.proxy = JCCollectionFlowProxy(collectionView: self.collectionView)
        
        var menuCells: [JCCellModel] = []
        self.menuList.forEach { (menuItem) in
            let cellModel = JCCellModel.init(cellClass: JCSwipeMenuCell.self)
            menuCells.append(cellModel)
        }
        let section = JCSectionModel(cellList: menuCells)
        // refresh collection view data
        self.proxy.sectionList = [section]
    }
    
}
