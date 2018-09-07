//
//  События презентера
//

protocol TagPublicationsPresenter {
    func loadPublications(byTag tag: String) -> Error?
}
