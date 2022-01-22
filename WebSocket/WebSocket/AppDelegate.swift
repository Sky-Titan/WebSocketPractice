//
//  AppDelegate.swift
//  WebSocket
//
//  Created by 박준현 on 2022/01/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let navVC = UINavigationController(rootViewController: ViewController())
        navVC.isNavigationBarHidden = true
        window?.rootViewController = navVC
        
        window?.makeKeyAndVisible()
        
        return true
    }

}

