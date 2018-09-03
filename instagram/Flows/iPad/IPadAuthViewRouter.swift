//
//  Обрабатывает логику переходов с экрана авторизации
//

import UIKit

class IPadAuthViewRouter: AbstractAuthViewRouter {
    // MARK: - Models
    // MARK: - Properties
    // MARK: - Fields
    
    weak var viewController: UIViewController!
    
    
    // MARK: - Functions
    
    func next() {
        viewController.performSegue(withIdentifier: "iPadShowProfile", sender: nil)
    }
    
    
    // MARK: - Services
    
    // MARK: - Initializers
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}
