//
//  Выполняет авторизацию пользователя, получает токен
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var userName: UILabel!
    
    
    // MARK: - Models
    
    var viewModel: AbstractProfileViewModel!
    var router: AbstractProfileViewRouter!
    
    
    // MARK: - Properties
    // MARK: - Fields
    // MARK: - IBActions
    
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userName.reactive.text <~ viewModel.username
    }
    
    
    // MARK: - Services
    // MARK: - Initializers
}
