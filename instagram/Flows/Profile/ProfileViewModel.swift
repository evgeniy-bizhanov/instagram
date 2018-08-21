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
    
    let service: ProfileService!
    
    
    // MARK: - Properties
    
    let username = Observable<String?>(nil)
    
    
    // MARK: - Fields
    // MARK: - Functions
    
    func initialize() {
        
        guard let token = Credentials.token else {
            return
        }
        
        service.profile(token: token) { [weak self] response in
            self?.username.value = response.value?.data.username
        }
    }
    
    
    // MARK: - Services
    
    // MARK: - Initializers
    
    init(service: ProfileService?) {
        self.service = service
        
        initialize()
    }
}
