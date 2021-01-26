//
//  JCSwipeMenuCell.swift
//  JCFlexableViewController
//
//  Created by justin zhang on 2021/1/19.
//

import UIKit

class JCSwipeMenuCell: UICollectionViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.contentView.addSubview(self.titleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleLabel.frame = self.contentView.bounds
    }
}
