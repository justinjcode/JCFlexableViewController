//
//  JCSectionModel.swift
//  JCFlexableViewController
//
//  Created by justin zhang on 2021/1/19.
//

import UIKit

class JCSectionModel: NSObject {
    
    var header: JCCellModel?
    var footer: JCCellModel?
    var cellList: [JCCellModel]
    var inset: UIEdgeInsets = .zero
    var cellLineSpace: CGFloat = 0
    
    init(header: JCCellModel? = nil, footer: JCCellModel? = nil, cellList: [JCCellModel]) {
        self.cellList = cellList
        super.init()
    }
    
}

class JCCellModel: NSObject {
    var cellClass: AnyClass
    var height: CGFloat = 0
    var selectCallback: ((UICollectionViewCell?)->())?
    
    init(cellClass: AnyClass) {
        self.cellClass = cellClass
        super.init()
    }
}
