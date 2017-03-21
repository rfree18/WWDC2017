import Foundation
import UIKit

open class Dock: UIView {
    var blurTintColor: UIColor! {
        set {
            toolbar.barTintColor = blurTintColor
        }
        get {
            return toolbar.barTintColor
        }
    }
    lazy var toolbar:UIToolbar = {
        // If we don't clip to bounds the toolbar draws a thin shadow on top
        self.clipsToBounds = true
        
        let toolbar = UIToolbar(frame: self.bounds)
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        self.insertSubview(toolbar, at: 0)
        let views = ["toolbar": toolbar]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[toolbar]|", options: [], metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[toolbar]|", options: [], metrics: nil, views: views))
        
        return toolbar
    }()
    
    
    public init(multiplier: CGFloat = 1) {
        let dockHeight: CGFloat = multiplier * 15.6
        let dockY = multiplier*104.05 - dockHeight
        super.init(frame: CGRect(x: 0, y: dockY, width: multiplier * 58.5, height: dockHeight))
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
        
//        blurTintColor = UIColor.red
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
