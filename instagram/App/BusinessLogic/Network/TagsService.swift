//
//  Контракт ленты пользователя
//

import Alamofire

protocol TagsService {
    
    /**
     Поиск тегов по имени
     
     - Parameter tagName: Имя тега, по которому выполняется поиск
     - Parameter token: Токен, содержащий информацию о пользователе
     */
    func search(
        byTagName tagName: String,
        token: String,
        completionHandler: @escaping (DataResponse<TagSearchResponse>) -> Void
    )
    
    /**
     Медиа пользователя имеющие тот или иной тег
     
     - Parameter tagName: Имя тега
     - Parameter token: Токен, содержащий информацию о пользователе
     */
    func recentMedia(
        byTagName tagName: String,
        token: String,
        completionHandler: @escaping (DataResponse<TagMediaRecentResponse>) -> Void
    )
    
    /**
     Информация о теге
     
     - Parameter tagName: Имя тега, для получения информации о нем
     - Parameter token: Токен, содержащий информацию о пользователе
     */
    func info(
        byTagName tagName: String,
        token: String,
        completionHandler: @escaping (DataResponse<TagInfoResponse>) -> Void
    )
}
