//
//  Модель представления сервиса авторизации
//

import Foundation

/// Модель представления экрана авторизации
protocol AbstractAuthViewModel {
    
    /// URL авторизации
    var url: URL? { get }
    
    /// Запрос авторизации
    var urlRequest: URLRequest? { get }
    
    
    /// Извлекает токен из переданного запроса
    func retrieveToken(request: URLRequest) -> Result<Bool>
}

class AuthViewModel: AbstractAuthViewModel {
    
    // MARK: - Models
    
    // MARK: - Properties
    
    var router: AbstractAuthViewRouter!
    
    
    // MARK: - Fields
    
    let clientId = "9882e5eb63b044e199a056dc221546b9"
    let redirectUri = "https://instagram.com"
    let oAuthUrl = "https://api.instagram.com/oauth/authorize/"
    
    lazy var url: URL? = {

        var components = URLComponents(string: oAuthUrl)

        components?.queryItems = [
            URLQueryItem(name: "client_id", value: clientId),
            URLQueryItem(name: "redirect_uri", value: redirectUri),
            URLQueryItem(name: "response_type", value: "token")
        ]

        return components?.url
    }()
    
    lazy var urlRequest: URLRequest? = {
        
        guard let url = url else {
            return nil
        }
        
        return URLRequest(url: url)
    }()
    
    // MARK: - Functions
    
    func retrieveToken(request: URLRequest) -> Result<Bool> {
        guard
            let fragment = request.url?.fragment,
            fragment.range(of: "access_token") != nil,
            let token = fragment.components(separatedBy: "access_token=").last else {
                return .error("Токен не обнаружен")
        }
        
        Credentials.token = token
        
        router.next()
        
        return .success(true)
    }
    
    
    // MARK: - Services
    
    
    // MARK: - Initializers
    
    init(router: AbstractAuthViewRouter?) {
        self.router = router
    }
}
