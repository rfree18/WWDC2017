import Foundation
import UIKit

open class AppCell: UICollectionViewCell {
    var textField: UITextField!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 0.3 * bounds.width
        textField = UITextField(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        textField.textAlignment = .center
        textField.isUserInteractionEnabled = false
        
        addSubview(textField)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
