//
//  Показывает публикации по тегу
//

import UIKit

class TagPublicationsViewController: UITableViewController, TagPublicationsView {
    
    // MARK: - IBOutlets
    // MARK: - Models
    
    var presenter: TagPublicationsPresenter!
    
    
    // MARK: - Properties
    
    var tag: VMTagInfo?
    
    
    // MARK: - Fields
    
    private var publications: [TagPublicationMedia]?
    
    
    // MARK: - IBActions
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let tag = tag?.name else {
            return
        }
        
        let error = presenter.loadPublications(byTag: tag)
        
        if let error = error {
            print(error)
        }
    }
    
    func didLoadPublications(publications: [TagPublicationMedia]) {
        self.publications = publications
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    
    // MARK: - Services
    // MARK: - Initializers
}

extension TagPublicationsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return publications?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "publicationCell", for: indexPath)
        
        let item = publications?[indexPath.row]
        
        cell.textLabel?.text = item?.id
        cell.detailTextLabel?.text = item?.url
        
        return cell
    }
}
