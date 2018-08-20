//
//  Разрешает зависимости для экрана авторизации
//

import Swinject

class AuthViewBuilder: AbstractModuleBuilder {
    @IBOutlet weak var vc: AuthViewController!
    
    override func resolve(resolver: Resolver) {
        vc.viewModel = resolver.resolve(AbstractAuthViewModel.self)
        vc.router = resolver.resolve(AbstractAuthViewRouter.self, argument: vc)
    }
}
