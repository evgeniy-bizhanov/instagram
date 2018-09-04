//
//  Сборщики зависимостей для отдельных сервисов
//

import Alamofire
import Swinject

/// Сборщик сервиса тегов
class TagsServiceAssembler: Assembly {
    func assemble(container: Container) {
        
        container.register(TagsService.self) { resolver in
            return Injector.makeFactory(ApiManager.self, resolver: resolver)
        }
        
        container.register(TagsViewModel.self) { _, service in
            return TagsViewModel(service: service)
        }
    }
}
