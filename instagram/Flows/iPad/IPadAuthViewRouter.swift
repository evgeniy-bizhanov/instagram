//
//  Обрабатывает логику переходов с экрана авторизации
//

import UIKit

/// Роутер переходов с экрана аутентификации
class IPadAuthViewRouter: AbstractAuthViewRouter {
    // MARK: - Models
    // MARK: - Properties
    // MARK: - Fields
    
    weak var viewController: UIViewController!
    
    
    // MARK: - Functions
    
    func next() {
        viewController.performSegue(withIdentifier: "showIPadProfile", sender: nil)
    }
    
    
    // MARK: - Services
    
    // MARK: - Initializers
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}
