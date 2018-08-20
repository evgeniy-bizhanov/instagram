//
//  Хранит токен
//

import Foundation

private let tokenKey = "token"

class Credentials {
    
    /// Проверяет авторизован ли пользователь
    static var isAuthorized: Bool {
        return token == nil ? false : true
    }
    
    /// Токен пользователя
    static var token: String? {
        get { return UserDefaults.standard.value(forKey: tokenKey) as? String }
        set { UserDefaults.standard.set(newValue, forKey: tokenKey) }
    }
}
