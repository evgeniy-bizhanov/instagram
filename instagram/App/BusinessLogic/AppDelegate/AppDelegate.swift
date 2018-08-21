//
//  AppDelegate.swift
//  instagram
//
//  Created by Евгений Бижанов on 19.08.2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        
        let storyboard = UIStoryboard(name: "Auth", bundle: nil)
        window?.rootViewController = storyboard.instantiateInitialViewController()
        window?.makeKeyAndVisible()
        
//        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
//        window?.rootViewController = storyboard.instantiateInitialViewController()
//        window?.makeKeyAndVisible()
        
        return true
    }
}
