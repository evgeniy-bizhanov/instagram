//
//  Разрешает зависимости для экрана авторизации
//

import Swinject

class AuthViewBuilder: AbstractModuleBuilder {
    @IBOutlet weak var viewController: AuthViewController!
    
    override func resolve(resolver: Resolver) {
        viewController.viewModel = resolver.resolve(AbstractAuthViewModel.self)
        
        viewController.router = resolver.resolve(
            AbstractAuthViewRouter.self,
            argument: viewController
        )
    }
}
