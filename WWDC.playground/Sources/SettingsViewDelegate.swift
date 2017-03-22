import Foundation
import UIKit

public protocol SettingsViewDelegate {
    func changeColor(color: UIColor)
    func getCurrentColor() -> UIColor?
}
