//
//  Сборщики зависимостей для отдельных сервисов
//

import Alamofire
import Swinject

/// Сборщик сервиса тегов
class TagPublicationsAssembler: Assembly {
    func assemble(container: Container) {
        
        container.register(TagsService.self) { resolver in
            return Injector.makeFactory(ApiManager.self, resolver: resolver)
        }
        
        container.register(TagPublicationsPresenter.self) { resolver, view in
            return TagPublicationsDefaultPresenter(
                tagsService: resolver.resolve(TagsService.self),
                tagsPublicationsView: view
            )
        }
    }
}
