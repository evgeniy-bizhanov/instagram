//
//  Модель представления сервиса авторизации
//

import Bond

/// Модель представления экрана авторизации
protocol AbstractProfileViewModel {
    var username: Observable<String?> { get }
}

class ProfileViewModel: AbstractProfileViewModel {
    
    // MARK: - Models
    
    let service: UserService!
    
    
    // MARK: - Properties
    
    let username = Observable<String?>(nil)
    
    
    // MARK: - Fields
    // MARK: - Functions
    
    func initialize() {
        
        guard let token = Credentials.token else {
            return
        }
        
        service.`self`(token: token) { [weak self] response in
            self?.username.value = response.value?.data.username
        }
        
        // TODO: - Временно, для отладки, к следующему ДЗ убрать
        service.media(token: token) { response in
            print(response.value?.data?[0])
        }
        
        let tags = service as! TagsService
        
        tags.info(byTagName: "test1", token: token) { response in
            print("INFO:---------------------------------------")
            print(response.value?.data)
        }
        
        tags.recentMedia(byTagName: "test1", token: token) { response in
            print("RECENT:---------------------------------------")
            print(response.value?.data)
        }
        
        tags.search(byTagName: "test1", token: token) { response in
            print("SEARCH:---------------------------------------")
            print(response.value?.data)
        }
    }
    
    
    // MARK: - Services
    
    // MARK: - Initializers
    
    init(service: UserService?) {
        self.service = service
        
        initialize()
    }
}
