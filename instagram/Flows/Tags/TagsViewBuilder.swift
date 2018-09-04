//
//  TagsViewBuilder
//

import Swinject

class TagsViewBuilder: AbstractModuleBuilder {
    @IBOutlet weak var viewController: TagsViewController!
    
    override func resolve(resolver: Resolver) {
        viewController.viewModel = resolver.resolve(
            TagsViewModel.self,
            arguments:
                resolver.resolve(TagsService.self),
                resolver.resolve(SnapshotManager.self)
        )
    }
}
