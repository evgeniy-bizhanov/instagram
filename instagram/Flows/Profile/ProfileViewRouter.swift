//
//  Обрабатывает логику переходов с экрана авторизации
//

import UIKit

/// Роутер переходов с экрана аутентификации
protocol AbstractProfileViewRouter { }

class ProfileViewRouter: AbstractProfileViewRouter {
    // MARK: - Models
    // MARK: - Properties
    // MARK: - Fields
    
    weak var viewController: ProfileViewController!
    
    
    // MARK: - Functions
    // MARK: - Services
    
    // MARK: - Initializers
    init(viewController: ProfileViewController?) {
        self.viewController = viewController
    }
}
