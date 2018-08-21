//
//  Сборщики зависимостей для отдельных сервисов
//

import Alamofire
import Swinject

/// Сборщик сервиса аутентификации
class AuthServiceAssembler: Assembly {
    func assemble(container: Container) {
        
        container.register(AbstractAuthViewModel.self) { _, router in
            return AuthViewModel(router: router)
        }
        
        container.register(AbstractAuthViewRouter.self) { _, vc in
            return AuthViewRouter(viewController: vc)
        }
    }
}
