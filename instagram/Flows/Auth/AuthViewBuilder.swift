//
//  Разрешает зависимости для экрана авторизации
//

import Swinject

class AuthViewBuilder: AbstractModuleBuilder {
    @IBOutlet weak var viewController: AuthViewController!
    
    override func resolve(resolver: Resolver) {
        
        let router = resolver.resolve(
            AbstractAuthViewRouter.self,
            argument: viewController as UIViewController?
        )
        
        viewController.viewModel = resolver.resolve(
            AbstractAuthViewModel.self,
            argument: router
        )
    }
}
