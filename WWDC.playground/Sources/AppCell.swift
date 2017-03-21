import Foundation
import UIKit

open class AppCell: UICollectionViewCell {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 0.3 * bounds.width
        backgroundColor = UIColor.blue
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
