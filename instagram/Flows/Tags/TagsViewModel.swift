//
//  Модель представления для экрана поиска по тегам
//

import Bond
import ReactiveKit

struct VMTagInfo: Decodable {
    let name: String
    let mediaCount: Int
    
    var displayName: String {
        return "#\(name)"
    }
    
    var displayMediaCount: String {
        return "\(mediaCount) публикаций"
    }
}

class TagsViewModel {
    
    typealias SearchCompletion = () -> Void
    
    // MARK: - Models
    // MARK: - Properties
    
    var searchResult: [VMTagInfo]?
    var searchCompletion: SearchCompletion?
    
    
    // MARK: - Fields
    
    let searchString = Observable<String?>(nil)
    private var disposing: Disposable?
    
    
    // MARK: - Functions
    
    func search(forTag tag: String) {
        
        guard let token = Credentials.token else {
            return
        }
        
        service.search(byTagName: tag, token: token) { [weak self] response in
            
            if let items = response.value?.data {
                self?.searchResult = try? items.map()
            } else {
                self?.searchResult = nil
            }
            
            self?.searchCompletion?()
        }
    }
    
    
    // MARK: - Services
    
    let service: TagsService!
    
    
    // MARK: - Initializers
    
    init(service: TagsService?) {
        self.service = service
        
        disposing = searchString.ignoreNil().debounce(interval: 1).observeNext { [weak self] in
            self?.search(forTag: $0)
        }
    }
    
    // MARK: - Deinitializers
    
    deinit {
        disposing?.dispose()
    }
}
