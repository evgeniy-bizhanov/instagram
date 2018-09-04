//
//  TagsViewBuilder
//

import Swinject

class TagsViewBuilder: AbstractModuleBuilder {
    @IBOutlet weak var viewController: TagsViewController!
    
    override func resolve(resolver: Resolver) {
        viewController.viewModel = resolver.resolve(
            TagsViewModel.self,
            argument: resolver.resolve(TagsService.self)
        )
    }
}
