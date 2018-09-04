//
//  Модель представления для экрана поиска по тегам
//

import Bond
import ReactiveKit

struct VMTagInfo: Decodable {
    let name: String
    let mediaCount: Int
    
    var displayName: String {
        return "#\(name)"
    }
    
    var displayMediaCount: String {
        return "\(mediaCount) публикаций"
    }
}

class TagsViewModel {
    
    typealias SearchCompletion = () -> Void
    
    // MARK: - Models
    // MARK: - Properties
    
    var searchResult: [VMTagInfo]?
    var searchCompletion: SearchCompletion?
    
    
    // MARK: - Fields
    
    let searchString = Observable<String?>(nil)
    private var disposing: Disposable?
    
    private lazy var snapshotId: String = String(describing: SearchTagsSnapshot.self)
    
    // MARK: - Functions
    
    func search(forTag tag: String) {
        
        guard let token = Credentials.token else {
            return
        }
        
        service.search(byTagName: tag, token: token) { [weak self] response in
            
            if let items = response.value?.data {
                self?.searchResult = try? items.map()
            } else {
                self?.searchResult = nil
            }
            
            self?.searchCompletion?()
        }
    }
    
    
    // MARK: - Services
    
    let service: TagsService!
    let snapshotManager: SnapshotManager!
    
    
    // MARK: - Initializers
    
    fileprivate func setupViewModel() {
        disposing = searchString.ignoreNil().debounce(interval: 1).observeNext { [weak self] in
            self?.search(forTag: $0)
            
            // Здесь можно через прокси делать снепшот, перед или после вызова метода search,
            // будет вообще 🔥
            if let snapshot = self?.snapshot() {
                self?.snapshotManager.save(snapshot: snapshot)
            }
        }
    }
    
    init(service: TagsService?, snapshotManager: SnapshotManager?) {
        self.service = service
        self.snapshotManager = snapshotManager
        
        setupViewModel()
        restoreFromSnapshot()
    }
    
    // MARK: - Deinitializers
    
    deinit {
        disposing?.dispose()
    }
}

// MARK: - Snapshots

extension TagsViewModel {
    fileprivate struct SearchTagsSnapshot: Snapshot {
        var id: String
        
        let token: String
        let searchText: String?
    }
    
    fileprivate func restoreFromSnapshot() {
        guard
            let snapshot: SearchTagsSnapshot = snapshotManager?.snapshot(with: snapshotId),
            let token = Credentials.token, snapshot.token == token else {
                return
        }
        
        searchString.value = snapshot.searchText
    }
    
    fileprivate func snapshot() -> SearchTagsSnapshot? {
        guard let token = Credentials.token else {
            return nil
        }
        
        return SearchTagsSnapshot(
            id: snapshotId,
            token: token,
            searchText: searchString.value
        )
    }
}
