//
//  Создает корневой контроллер в зависимости от типа устройства и авторизации пользователя
//

import UIKit

class RootControllerFactory {
    func viewController() -> UIViewController? {
        let director = RootControllerBuilder()
//        Credentials.logout()
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            director.builder = IPhoneFactory()
        case .pad:
            director.builder = IPadFactory()
        default:
            assertionFailure("Устройство не поддерживается")
        }
        
        director.construct()
        
        return director.viewController
    }
}
