//
//  Выполняет авторизацию пользователя, получает токен
//

import UIKit
import WebKit

class AuthViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var webView: WKWebView!
    
    
    // MARK: - Models
    
    var viewModel: AbstractAuthViewModel!
    
    
    // MARK: - Properties
    // MARK: - Fields
    // MARK: - IBActions
    
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        removeCache()
        webView.navigationDelegate = self
        
        if let urlRequest = viewModel.urlRequest {
            webView.load(urlRequest)
        }
    }
    
    private func removeCache() {
        let datastore = WKWebsiteDataStore.default()
        datastore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach {
                datastore.removeData(ofTypes: $0.dataTypes, for: [$0], completionHandler: { })
            }
        }
    }
    
    
    // MARK: - Services
    // MARK: - Initializers
}

extension AuthViewController: WKNavigationDelegate {
    
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        let request = navigationAction.request
        let result = viewModel.retrieveToken(request: request)
        
        let decision: WKNavigationActionPolicy
        
        switch result {
        case .error:
            decision = .allow
        case .success(let token):
            viewModel.retrieved(token: token)
            decision = .cancel
        }

        decisionHandler(decision)
    }
}
