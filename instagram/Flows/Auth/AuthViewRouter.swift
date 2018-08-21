//
//  Обрабатывает логику переходов с экрана авторизации
//

import UIKit

/// Роутер переходов с экрана аутентификации
protocol AbstractAuthViewRouter: class {
    func next()
}

class AuthViewRouter: AbstractAuthViewRouter {
    // MARK: - Models
    // MARK: - Properties
    // MARK: - Fields
    
    weak var viewController: AuthViewController!
    
    
    // MARK: - Functions
    
    func next() {
        viewController.performSegue(withIdentifier: "showProfile", sender: nil)
    }
    
    
    // MARK: - Services
    
    // MARK: - Initializers
    init(viewController: AuthViewController?) {
        self.viewController = viewController
    }
}
