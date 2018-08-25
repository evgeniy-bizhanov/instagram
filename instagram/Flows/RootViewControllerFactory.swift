//
//  Создает корневой контроллер в зависимости от типа устройства и авторизации пользователя
//

import UIKit

class RootControllerFactory {
    func viewController() -> UIViewController? {
        let director = RootControllerBuilder()
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            director.builder = FirstViewControllerBuilder()
        case .pad:
            director.builder = FirstViewControllerIPadBuilder()
        default:
            assertionFailure("Устройство не поддерживается")
        }
        
        director.construct()
        
        return director.viewController
    }
}
