import Foundation
import UIKit

open class Screen: UIView {
    
    let imgView = UIImageView()
    
    public init(multiplier: CGFloat = 1) {
        super.init(frame: CGRect(x: multiplier * 4.31, y: multiplier * 17.12, width: multiplier * 58.5, height: multiplier*104.05))
        
        imgView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        let bgImg = UIImage(named: "bg3.png")
        imgView.image = bgImg
        addSubview(imgView)
        
        addSubview(Dock(multiplier: multiplier))
//        let blurEffect = UIBlurEffect(style: .light)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        let dockHeight: CGFloat = multiplier * 15.6
//        let dockY = multiplier*104.05 - dockHeight
//        blurEffectView.frame = CGRect(x: 0, y: dockY, width: multiplier * 58.5, height: dockHeight)
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        addSubview(blurEffectView)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
