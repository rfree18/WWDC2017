import Foundation
import UIKit

open class Dock: UIView {
    public init(multiplier: CGFloat = 1) {
        let dockHeight: CGFloat = multiplier * 15.6
        let dockY = multiplier*104.05 - dockHeight
        super.init(frame: CGRect(x: 0, y: dockY, width: multiplier * 58.5, height: dockHeight))
        
        // Add transulency to dock
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        
        addSubview(blurEffectView)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
