//
//  JCFlexableView.swift
//  JCFlexableViewController
//
//  Created by justin zhang on 2021/1/19.
//

import UIKit

enum JCParentSection: Int {
    case headerSection = 0
    case contentSection
}

class JCFlexableView: UIView {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let view = UICollectionView.init(frame: self.bounds, collectionViewLayout: layout)
        
        view.scrollWithOther = true
        return view
    }()
    
    var proxy: JCCollectionFlowProxy!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.addSubview(self.collectionView)
        self.proxy = JCCollectionFlowProxy(collectionView: self.collectionView)
        self.configData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.collectionView.frame = self.bounds
    }
    
    public func configData() {
        //header
        let headerCell = JCCellModel(cellClass: JCTestHeaderCell.self)
        headerCell.height = 200
        headerCell.selectCallback = { cell in
            print("did click header cell")
        }
        let headerSection = JCSectionModel(header: nil, footer: nil, cellList: [headerCell])
        //content
        let contentCell = JCCellModel(cellClass: JCTestContentCell.self)
        contentCell.height = self.frame.size.height
        let contentSection = JCSectionModel(header: nil, footer: nil, cellList: [contentCell])
        
        // refresh collection view data
        self.proxy.sectionList = [headerSection, contentSection]
    }
    
}

