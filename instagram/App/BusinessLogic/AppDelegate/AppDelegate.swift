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
//        window?.rootViewController = RootControllerFactory().viewController()
        window?.rootViewController = firstViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    // Мост?
    //
    // Не уверен, является ли обязательным условием вызов некоторого метода контроллера, который будет
    // дергать метод роутера, что то вроде controller.next()
    //
    // По описанию шаблона это должно происходить именно так, здесь же метод роутера next() вызывается косвенно,
    // внутри самого контроллера
    func firstViewController() -> UIViewController? {
        guard let controller: AuthViewController = instantiateViewController() else {
            fatalError()
        }
        
        let router: AbstractAuthViewRouter
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            router = IPadAuthViewRouter(viewController: controller)
        default:
            router = AuthViewRouter(viewController: controller)
        }
        
        controller.router = router
        
        return controller
    }
}

extension AppDelegate {
    func instantiateViewController<T>() -> T? {
        let name = String(describing: T.self).replacingOccurrences(of: "ViewController", with: "")
        let storyboard = UIStoryboard(name: name, bundle: nil)
        return storyboard.instantiateInitialViewController() as? T
    }
}
