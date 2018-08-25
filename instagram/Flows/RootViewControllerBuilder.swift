//
//  Билдер корневого контроллера
//

import UIKit

// Совмещенный director и builder
final class RootControllerBuilder {
    var builder: Builder?
    
    var viewController: UIViewController?
    
    func construct() {
        viewController = builder?.viewController(isAuthenticated: Credentials.isAuthorized)
        
        // Add router etc.
    }
}
