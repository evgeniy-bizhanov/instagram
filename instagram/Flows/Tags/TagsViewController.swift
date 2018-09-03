//
//  Контроллер для работы с поиском тегов
//

import UIKit

class TagsViewController: UITableViewController {
    
    // MARK: - IBOutlets
    // MARK: - Models
    // MARK: - Properties
    
    // MARK: - Fields
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    // MARK: - IBActions
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search.."
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        
        definesPresentationContext = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    
    // MARK: - Services
    // MARK: - Initializers
}

extension TagsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // TODO:
    }
}
