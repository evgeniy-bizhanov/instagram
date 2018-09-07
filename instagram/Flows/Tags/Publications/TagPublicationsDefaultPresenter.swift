//
//  Презентер контроллера публикаций по тегам
//

enum RequestError: Error {
    case notAuthorized
}

class TagPublicationsDefaultPresenter: TagPublicationsPresenter {
    
    // MARK: - Models
    
    let tagsService: TagsService!
    
    
    // MARK: - Properties
    // MARK: - Fields
    
    weak var tagsPublicationsView: TagPublicationsView!
    
    
    // MARK: - Functions
    
    func loadPublications(byTag tag: String) -> Error? {
        
        guard let token = Credentials.token else {
            return RequestError.notAuthorized
        }
        
        tagsService.recentMedia(byTagName: tag, token: token) { [weak self] response in
            
            let data = response.value?.data.compactMap {
                TagPublicationMedia(
                    id: $0.id,
                    url: $0.images?.standard?.url
                )
            }
            
            if let data = data {
                self?.tagsPublicationsView.didLoadPublications(publications: data)
            }
        }
        
        return nil
    }
    
    
    // MARK: - Services
    // MARK: - Initializers
    
    init(tagsService: TagsService?, tagsPublicationsView: TagPublicationsView?) {
        self.tagsService = tagsService
        self.tagsPublicationsView = tagsPublicationsView
    }
}
