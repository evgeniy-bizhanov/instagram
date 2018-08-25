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
    func retrieveToken(request: URLRequest) -> Result<String>
    
    /// Завершает авторизацию, с полученным токеном
    func retrieved(token: String)
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
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "scope", value: "basic+public_content+comments+relationships+likes+follower_list")
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
    
    func retrieveToken(request: URLRequest) -> Result<String> {
        guard
            let fragment = request.url?.fragment,
            fragment.range(of: "access_token") != nil,
            let token = fragment.components(separatedBy: "access_token=").last else {
                return .error("Токен не обнаружен")
        }

        return .success(token)
    }
    
    func retrieved(token: String) {
        Credentials.token = token
        router.next()
    }
    
    
    // MARK: - Services
    
    
    // MARK: - Initializers
    
    init(router: AbstractAuthViewRouter?) {
        self.router = router
    }
}
