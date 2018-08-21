//
//  Разрешает зависимости для экрана авторизации
//

import Swinject

class ProfileViewBuilder: AbstractModuleBuilder {
    @IBOutlet weak var viewController: ProfileViewController!
    
    override func resolve(resolver: Resolver) {
        
        viewController.viewModel = resolver.resolve(
            AbstractProfileViewModel.self,
            argument: resolver.resolve(ProfileService.self)
        )
        
        viewController.router = resolver.resolve(
            AbstractProfileViewRouter.self,
            argument: viewController as UIViewController?
        )
    }
}
