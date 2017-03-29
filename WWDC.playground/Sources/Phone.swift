import Foundation
import UIKit
import AVFoundation

open class Phone: UIView {
    var homeButton = UIButton(frame: CGRect(x: 28.11, y: 129.1, width: 10.90, height: 10.90))
    var screen: Screen!
    let player = AVPlayer()
    
    /* 
        NOTE: This was originally built with a multiplier argument to allow for variable display sizes. 
        However, multiplier should always be set to 5 since certain display elements do not dynamically adjust size
     */
    public init(multiplier: CGFloat = 5, player: AVQueuePlayer) {
        super.init(frame: CGRect(x: 0, y: 0, width: multiplier * 67.1, height: multiplier * 138.3))
        backgroundColor = UIColor.black
        layer.cornerRadius = CGFloat(8 * multiplier)
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 0.5
        clipsToBounds = true
        
        // Setup home button
        homeButton.frame = CGRect(x: multiplier * 28.11, y: multiplier * 123.67, width: multiplier * 10.90, height: multiplier * 10.90)
        homeButton.layer.cornerRadius = CGFloat(5.45 * multiplier)
        homeButton.clipsToBounds = true
        homeButton.layer.borderWidth = 1
        homeButton.layer.borderColor = UIColor.gray.cgColor
        homeButton.backgroundColor = UIColor.black
        homeButton.addTarget(self, action: #selector(homeButtonPressed), for: .touchUpInside)
        addSubview(homeButton)
        
        let screenBackground = UIView(frame: CGRect(x: multiplier * 4.31, y: multiplier * 17.12, width: multiplier * 58.5, height: multiplier*104.05))
        screenBackground.backgroundColor = UIColor.black
        addSubview(screenBackground)
        
        screen = Screen(multiplier: multiplier, player: player)
        addSubview(screen)
        
        // Speaker grille at top of phone
        let receiver = UIView(frame: CGRect(x: multiplier * 27.62, y: multiplier * 9.08, width: multiplier * 11.87, height: multiplier * 1.20))
        receiver.backgroundColor = UIColor.gray
        receiver.layer.cornerRadius = 5
        addSubview(receiver)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateColor(color: UIColor) {
        backgroundColor = color
        homeButton.backgroundColor = color
    }
    
    func homeButtonPressed() {
        screen.closeApp()
    }
}
