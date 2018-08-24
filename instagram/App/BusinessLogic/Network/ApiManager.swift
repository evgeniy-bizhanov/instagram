//
//  Выполняет запросы к профилю пользователя
//

import Alamofire

class ApiManager: RequestManager { }


// MARK: - Profile

extension ApiManager: UserService {
    
    func `self`(
        token: String,
        completionHandler: @escaping (DataResponse<UserResponse>) -> Void) {
        
        let requestModel = User(baseUrl: baseUrl, token: token)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func media(
        token: String,
        completionHandler: @escaping (DataResponse<MediaResponse>) -> Void) {
        
        let requestModel = Media(baseUrl: baseUrl, token: token)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension ApiManager {
    struct User: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "users/self"
        
        let token: String
        
        var parameters: Parameters? {
            return [
                "access_token": token
            ]
        }
    }
    
    struct Media: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "users/self/media/recent"
        
        let token: String
        
        var parameters: Parameters? {
            return [
                "access_token": token
            ]
        }
    }
}


// MARK: - Tags

extension ApiManager: TagsService {
    
    func search(
        byTagName tagName: String,
        token: String,
        completionHandler: @escaping (DataResponse<TagSearchResponse>) -> Void) {
        
        let requestModel = TagSearch(baseUrl: baseUrl, tagName: tagName, token: token)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func recentMedia(
        byTagName tagName: String,
        token: String,
        completionHandler: @escaping (DataResponse<TagMediaRecentResponse>) -> Void) {
        
        let requestModel = TagMediaRecent(baseUrl: baseUrl, tagName: tagName, token: token)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func info(
        byTagName tagName: String,
        token: String,
        completionHandler: @escaping (DataResponse<TagInfoResponse>) -> Void) {
        
        let requestModel = TagInfo(baseUrl: baseUrl, tagName: tagName, token: token)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension ApiManager {
    struct TagSearch: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "tags/search"

        let tagName: String
        let token: String

        var parameters: Parameters? {
            return [
                "q": tagName,
                "access_token": token
            ]
        }
    }
    
    struct TagMediaRecent: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String
        
        let token: String
        
        var parameters: Parameters? {
            return [
                "access_token": token
            ]
        }
        
        init(baseUrl: URL, tagName: String, token: String) {
            self.baseUrl = baseUrl
            self.token = token
            self.path = "tags/\(tagName)/media/recent"
        }
    }
    
    struct TagInfo: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String
        
        let token: String
        
        var parameters: Parameters? {
            return [
                "access_token": token
            ]
        }
        
        init(baseUrl: URL, tagName: String, token: String) {
            self.baseUrl = baseUrl
            self.token = token
            self.path = "tags/\(tagName)"
        }
    }
}
