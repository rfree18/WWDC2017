import Foundation
import UIKit

open class SettingsView: UIView {
    let hexArray = [ 0x000000, 0xfe0000, 0xff7900, 0xffb900, 0xffde00, 0xfcff00, 0xd2ff00, 0x05c000, 0x00c0a7, 0x0600ff, 0x6700bf, 0x9500c0, 0xbf0199, 0xffffff ]
    var colorArray: [UIColor]!
    var slider: UISlider!
    public var delegate: SettingsViewDelegate?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        
        colorArray = [UIColor]()
        for hex in hexArray {
            colorArray.append(uiColorFromHex(rgbValue: hex))
        }
        
        slider = UISlider(frame: frame)
        slider.maximumValue = Float(colorArray.endIndex - 1)
        slider.addTarget(self, action: #selector(self.sliderChanged), for: .valueChanged)
        
        if let currentColor = delegate?.getCurrentColor() {
            var ind: Int?
            
            for (index, color) in colorArray.enumerated() {
                if(currentColor.isEqual(color)) {
                    ind = index
                    break
                }
            }
            
            if let index = ind {
                slider.setValue(Float(index), animated: false)
            }
        }
        
        addSubview(slider)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func sliderChanged() {
        let selectedColor = colorArray[Int(slider.value)]
        delegate?.changeColor(color: selectedColor)
    }
    
    func uiColorFromHex(rgbValue: Int) -> UIColor {
        
        let red =   CGFloat((rgbValue & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 0xFF
        let blue =  CGFloat(rgbValue & 0x0000FF) / 0xFF
        let alpha = CGFloat(1.0)
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
