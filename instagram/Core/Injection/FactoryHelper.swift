//
//  Подготовка фабрики к внедрению
//

import Alamofire
import Swinject

/// Хелпер для подготовки объектов внедрения
class FactoryHelper {
    
    /**
     Создает сервисы по их типам
     
     - Parameters:
       - service: Тип сервиса, которых необходимо создать
       - resolver: Контейнер разрешения зависимостей
     */
    static func makeFactory<T: AbstractRequestManager>(_ service: T.Type, resolver: Resolver) -> T {
        
        let errorParser = resolver.resolve(​AbstractErrorParser​.self)
        let sessionManager = resolver.resolve(SessionManager.self)
        let sessionQueue = resolver.resolve(DispatchQueue.self)
        
        // swiftlint:disable force_unwrapping
        return T(
            errorParser: errorParser!,
            sessionManager: sessionManager!,
            queue: sessionQueue
        )
        // swiftlint:enable force_unwrapping
    }
    
    /// Создает и конфигурирует менеджер сессий
    static func makeSessionManager() -> SessionManager {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        
        let manager = SessionManager(configuration: configuration)
        return manager
    }
}
