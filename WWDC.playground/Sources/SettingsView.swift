import Foundation
import UIKit

open class SettingsView: UIView {
    var slider: UISlider!
    public var delegate: SettingsViewDelegate? {
        didSet {
            // Set slider to current color
            if let colorId = delegate?.getCurrentColorId(){
                slider.setValue(Float(colorId), animated: false)
            }
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        
        slider = UISlider(frame: frame)
        // Current number of possible colors is 13
        slider.maximumValue = 13.0
        slider.addTarget(self, action: #selector(self.sliderChanged), for: .valueChanged)
        
        addSubview(slider)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func sliderChanged() {
        let selectedId = Int(slider.value)
        delegate?.changeColor(colorId: selectedId)
    }
}
