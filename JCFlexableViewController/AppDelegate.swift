//
//  AppDelegate.swift
//  JCFlexableViewController
//
//  Created by justin zhang on 2021/1/18.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var launchOptions: [UIApplication.LaunchOptionsKey: Any]?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.launchOptions = launchOptions
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let vc = ViewController()
        let nav = UINavigationController(rootViewController: vc)
        window?.rootViewController = nav
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        
        return true
    }

}

