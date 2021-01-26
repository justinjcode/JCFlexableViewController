//
//  JCSwipeViewController.swift
//  JCFlexableViewController
//
//  Created by justin zhang on 2021/1/19.
//

import UIKit

class JCSwipeViewController: UIViewController {
    
    lazy var menuView: JCSwipeMenuView = {
        let view = JCSwipeMenuView()
        return view
    }()
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.menuView.frame = CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: 40)
    }
    
    public func reloadMenus(_ menuList:[JCSwipeMenuItem]) {
        self.menuView.reloadMenus(menuList)
    }
    
    
    
}
