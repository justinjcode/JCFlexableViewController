//
//  JCTestContentCell.swift
//  JCFlexableViewController
//
//  Created by justin zhang on 2021/1/19.
//

import UIKit

class JCTestContentCell: UICollectionViewCell {
    
    var contentVC: JCSwipeViewController = JCSwipeViewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.contentView.addSubview(self.contentVC.view)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentVC.view.frame = self.bounds
    }
    
}
