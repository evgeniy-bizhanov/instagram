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
        window?.rootViewController = rootViewControllerFactory()?.viewController()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func rootViewControllerFactory() -> AbstractViewControllerFactory? {
        guard let device = Device(rawValue: UIDevice.current.userInterfaceIdiom.rawValue) else {
            return nil
        }
        
        let factory: AbstractViewControllerFactory
        
        // Не нравится, что в одном случае вынужден устройство проверять снаружи,
        // в другом - внутри
        //
        // По идее нужно создать древовидную структуру, что бы в одной фабрике проверять авторизован ли пользователь,
        // в другой - какой тип устройства используется, что бы:
        // - во первых избежать ветвлений if
        // - во вторых инкапсулировать проверки именно в тех местах, где они непосредственно нужны
        //
        // Здесь же получается, из-за того, что мы передаем билдеры из-вне, приходится проверку устройств выносить наружу
        
        if Credentials.isAuthorized {
            let builder: ProfileViewControllerBuilder = device == .pad ? IPadProfileBuilder() : IPhoneProfileBuilder()
            
            factory = ProfileViewControllerFactory(
                builder: builder
            )
        } else {
            factory = AuthViewControllerFactory(
                device: device,
                builder: AuthenticationBuilder()
            )
        }
        
        return factory
    }
}


protocol ViewControllerBuilder {
    func reset()
    func resultViewController() -> UIViewController
}

extension ViewControllerBuilder {
    fileprivate func buildViewController<T>(ofType type: T.Type = T.self) -> T? {
        let name = String(describing: type).replacingOccurrences(of: "ViewController", with: "")
        let storyboard = UIStoryboard(name: name, bundle: nil)
        return storyboard.instantiateInitialViewController() as? T
    }
    
    // На скорую руку для упрощения
    fileprivate func buildApiManager() -> ApiManager {
        let parser = ErrorParser()
        let sessionManager = Injector.makeSessionManager()
        
        return ApiManager(
            errorParser: parser,
            sessionManager: sessionManager,
            queue: DispatchQueue.global(qos: .utility)
        )
    }
}

protocol AuthViewControllerBuilder: ViewControllerBuilder {
    func buildViewModel()
    func buildIPhoneRouter()
    func buildIPadRouter()
}

protocol ProfileViewControllerBuilder: ViewControllerBuilder {
    func buildViewModel()
    func buildRouter()
}

final class AuthenticationBuilder: AuthViewControllerBuilder {
    
    private lazy var result: AuthViewController! = buildViewController()
    
    func reset() {
        result = buildViewController()
    }

    func buildViewModel() {
        result.viewModel = AuthViewModel()
    }
    
    func buildIPhoneRouter() {
        result.router = AuthViewRouter(viewController: result)
    }
    
    func buildIPadRouter() {
        result.router = IPadAuthViewRouter(viewController: result)
    }
    
    func resultViewController() -> UIViewController {
        return result
    }
}

final class IPhoneProfileBuilder: ProfileViewControllerBuilder {
    
    private lazy var result: ProfileViewController! = buildViewController()
    
    func reset() {
        result = buildViewController()
    }

    func buildViewModel() {
        result.viewModel = ProfileViewModel(service: buildApiManager())
    }
    
    func buildRouter() {
        result.router = ProfileViewRouter(viewController: result)
    }
    
    func resultViewController() -> UIViewController {
        return result
    }
}

final class IPadProfileBuilder: ProfileViewControllerBuilder {
    
    private lazy var result: IPadProfileViewController! = buildViewController()
    
    func reset() {
        result = buildViewController()
    }

    func buildViewModel() {
        // result.viewModel = ...
    }
    
    func buildRouter() {
        // result.router = ...
    }
    
    func resultViewController() -> UIViewController {
        return result
    }
}

enum Device: Int {
    case phone
    case pad
}

protocol AbstractViewControllerFactory {
    func viewController() -> UIViewController?
}

final class AuthViewControllerFactory: AbstractViewControllerFactory { //Директор
    
    var builder: AuthViewControllerBuilder?
    
    private let device: Device
    
    init(device: Device, builder: AuthViewControllerBuilder) {
        self.builder = builder
        self.device = device
    }
    
    func viewController() -> UIViewController? {
        builder?.reset()
        builder?.buildViewModel()
        
        switch device {
        case .pad:
            builder?.buildIPadRouter()
        default:
            builder?.buildIPhoneRouter()
        }
        
        return builder?.resultViewController()
    }
}

final class ProfileViewControllerFactory: AbstractViewControllerFactory { //Директор
    
    var builder: ProfileViewControllerBuilder?
    
    init(builder: ProfileViewControllerBuilder) {
        self.builder = builder
    }
    
    func viewController() -> UIViewController? {
        builder?.reset()
        builder?.buildViewModel()
        builder?.buildRouter()
        
        return builder?.resultViewController()
    }
}
