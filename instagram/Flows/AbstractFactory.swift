//
//  Фабрика создания контроллеров, по необходимому типу
//

import UIKit

private enum ControllerType: String, CustomStringConvertible {
    
    /// Контроллер авторизации
    case auth
    
    /// Контроллер профиля пользователя
    case profile
    
    /// Контроллер авторизации для iPad
    case iPadAuth
    
    /// Контроллер профиля пользователя для iPad
    case iPadProfile
    
    var description: String {
        return self.rawValue.capitalizingFirstLetter()
    }
}

protocol Builder {
    
    /**
     Создает контрллер на основании авторизации пользователя
     
     - Parameter authenticated: Указывает на то, авторизован пользователь или нет
     */
    func viewController(isAuthenticated authenticated: Bool) -> UIViewController?
}

/// Абстрактная фабрика создания контроллеров
class AbstractFactory {

    /**
     Создает один из зарегистрированных типов контроллера
     
     - Parameter type: Тип контроллера `ControllerType`, который необходимо создать
     */
    fileprivate func viewController(ofType type: ControllerType) -> UIViewController? {
        let storyboard = UIStoryboard(name: type.description, bundle: nil)
        return storyboard.instantiateInitialViewController()
    }
}

final class FirstViewControllerBuilder: AbstractFactory, Builder {
    
    func viewController(isAuthenticated authenticated: Bool) -> UIViewController? {
        return viewController(ofType: authenticated ? .profile : .auth)
    }
}

final class FirstViewControllerIPadBuilder: AbstractFactory, Builder {
    
    func viewController(isAuthenticated authenticated: Bool) -> UIViewController? {
        return viewController(ofType: authenticated ? .iPadProfile : .iPadAuth)
    }
}
