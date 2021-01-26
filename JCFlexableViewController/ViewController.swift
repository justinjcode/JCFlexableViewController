//
//  ViewController.swift
//  JCFlexableViewController
//
//  Created by justin zhang on 2021/1/18.
//

import UIKit



class ViewController: UIViewController {
    
    lazy var flexableView: JCFlexableView = {
        let view = JCFlexableView(frame: self.view.bounds)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.flexableView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.flexableView.frame = self.view.bounds
    }
    
    
}

