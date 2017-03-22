import Foundation
import UIKit

public protocol SettingsViewDelegate {
    func changeColor(colorId: Int)
    func getCurrentColorId() -> Int
}
