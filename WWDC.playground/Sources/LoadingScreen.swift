import Foundation
import UIKit

open class LoadingScreen: UIView {
    var imageView: UIImageView!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.black
        
        let image = UIImage(named: "apl.png")
        imageView = UIImageView(frame: CGRect(x: frame.width/2, y: frame.height/2, width: 400/3, height: 100))
        imageView.image = image
        
        addSubview(imageView)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
