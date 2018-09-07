//
//  Билдер для контроллера публикаций по тегам
//

import Swinject

class TagPublicationsBuilder: AbstractModuleBuilder {
    
    @IBOutlet weak var viewController: TagPublicationsViewController!
    
    override func resolve(resolver: Resolver) {
        let presenter = resolver.resolve(
            TagPublicationsPresenter.self,
            argument: viewController as TagPublicationsView?
        )
        
        viewController.presenter = presenter
    }
}
