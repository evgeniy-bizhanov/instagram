//
//  Сборщики зависимостей для отдельных сервисов
//

import Alamofire
import Swinject

/// Сборщик сервиса аутентификации
class ProfileServiceAssembler: Assembly {
    func assemble(container: Container) {
        
        container.register(UserService.self) { resolver in
            return Injector.makeFactory(ApiManager.self, resolver: resolver)
        }
        
        container.register(AbstractProfileViewModel.self) { _, service in
            return ProfileViewModel(service: service)
        }
        
        container.register(AbstractProfileViewRouter.self) { _, vc in
            return ProfileViewRouter(viewController: vc)
        }
    }
}
