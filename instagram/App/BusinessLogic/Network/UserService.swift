//
//  Контракт профиля пользователя
//

import Alamofire

protocol UserService {
    
    /**
     Получает профиль пользователя от сервера
     
     - Parameter token: Токен, содержащий информацию о пользователе
     */
    func `self`(
        token: String,
        completionHandler: @escaping (DataResponse<UserResponse>) -> Void
    )
    
    /**
     Получает медиа-ленту пользователя
     
     - Parameter token: Токен, содержащий информацию о пользователе
     */
    func media(
        token: String,
        completionHandler: @escaping (DataResponse<MediaResponse>) -> Void
    )
}
