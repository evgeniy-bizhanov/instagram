//
//  Контроллер для тестов
//

import UIKit

class IPadProfileViewController: UIViewController {
    @IBOutlet var rootView: UIView!
    @IBOutlet weak var childView1: UIView!
    @IBOutlet weak var childView2: UIView!
    @IBOutlet weak var childView3: UIView!
    
    @IBOutlet weak var rootViewLabel: UILabel!
    @IBOutlet weak var childViewLabel1: UILabel!
    @IBOutlet weak var childViewLabel2: UILabel!
    @IBOutlet weak var childViewLabel3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootViewLabel.text = rootView.coordsRelativeToWindow().debugDescription
        childViewLabel1.text = childView1.coordsRelativeToWindow().debugDescription
        childViewLabel2.text = childView2.coordsRelativeToWindow().debugDescription
        childViewLabel3.text = childView3.coordsRelativeToWindow().debugDescription
    }
}
