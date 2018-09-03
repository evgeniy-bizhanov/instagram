//
//  Расширения компонентов UIKit
//

import UIKit

extension UIView {
    func coordsRelativeToWindow() -> CGPoint {
        guard var point = superview?.coordsRelativeToWindow() else {
            return frame.origin
        }
        
        point.x += frame.origin.x
        point.y += frame.origin.y
        
        return point
    }
}
