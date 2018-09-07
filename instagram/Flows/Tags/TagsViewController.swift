//
//  Контроллер для работы с поиском тегов
//

import UIKit

class TagsViewController: UITableViewController {
    
    // MARK: - IBOutlets
    // MARK: - Models
    
    var viewModel: TagsViewModel!
    
    
    // MARK: - Properties
    
    // MARK: - Fields
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    // MARK: - IBActions
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search.."
        searchController.searchBar.reactive.text ~ viewModel.searchString
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        
        definesPresentationContext = true
        
        viewModel.searchCompletion = {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let selectedPath = tableView.indexPathForSelectedRow else {
            return
        }
        
        if let destination = segue.destination as? TagPublicationsViewController {
            destination.tag = viewModel.searchResult?[selectedPath.row]
        }
    }
    
    
    // MARK: - Services
    // MARK: - Initializers
}

//extension TagsViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        viewModel.searchString.value = searchController.searchBar.text
//    }
//}

extension TagsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchResult?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tagCell", for: indexPath)
        
        let item = viewModel.searchResult?[indexPath.row]
        
        cell.textLabel?.text = item?.displayName
        cell.detailTextLabel?.text = item?.displayMediaCount
        
        return cell
    }
}
