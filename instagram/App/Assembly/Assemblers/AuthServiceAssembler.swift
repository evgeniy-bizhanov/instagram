//
//  Сборщики зависимостей для отдельных сервисов
//

import Alamofire
import Swinject

/// Сборщик сервиса аутентификации
class AuthServiceAssembler: Assembly {
    func assemble(container: Container) {
        
        container.register(AbstractAuthViewModel.self) { _ in
            return AuthViewModel()
        }
        
        container.register(AbstractAuthViewRouter.self) { _ in
            return AuthViewRouter()
        }
    }
}
