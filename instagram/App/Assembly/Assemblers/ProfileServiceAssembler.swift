//
//  Сборщики зависимостей для отдельных сервисов
//

import Alamofire
import Swinject

/// Сборщик сервиса аутентификации
class ProfileServiceAssembler: Assembly {
    func assemble(container: Container) {
        
        container.register(ProfileService.self) { resolver in
            return Injector.makeFactory(ProfileRequest.self, resolver: resolver)
        }
        
        container.register(AbstractProfileViewModel.self) { _, service in
            return ProfileViewModel(service: service)
        }
        
        container.register(AbstractProfileViewRouter.self) { _, vc in
            return ProfileViewRouter(viewController: vc)
        }
    }
}
