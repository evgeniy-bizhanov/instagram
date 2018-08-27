//
//  Разрешает зависимости для экрана авторизации
//

import Swinject

class AuthViewBuilder: AbstractModuleBuilder {
    @IBOutlet weak var viewController: AuthViewController!
    
    override func resolve(resolver: Resolver) {
        self.resolveRouter(for: viewController, with: resolver)
        self.resolveViewModel(for: viewController, with: resolver)
    }
    
    fileprivate func resolveRouter(for controller: UIViewController, with resolver: Resolver) {
        viewController.router = resolver.resolve(
            AbstractAuthViewRouter.self,
            argument: viewController as UIViewController?
        )
    }
    
    fileprivate func resolveViewModel(for controller: UIViewController, with resolver: Resolver) {
        viewController.viewModel = resolver.resolve(
            AbstractAuthViewModel.self
        )
    }
}
