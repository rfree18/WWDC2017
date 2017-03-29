import Foundation
import AVFoundation
import UIKit

open class Screen: UIView {
    
    let imgView = UIImageView()
    var appCollection: UICollectionView!
    var multiplier: CGFloat!
    var player: AVQueuePlayer!
    
    let reuseId = "AppCell"
    let hexArray = [0x000000, 0xfe0000, 0xff7900, 0xffb900, 0xffde00, 0xfcff00, 0xd2ff00, 0x05c000, 0x00c0a7, 0x0600ff, 0x6700bf, 0x9500c0, 0xbf0199, 0xffffff]
    var currColorId = 0
    
    var appView: UIView?
    
    public init(multiplier: CGFloat = 5, player: AVQueuePlayer) {
        super.init(frame: CGRect(x: multiplier * 4.31, y: multiplier * 17.12, width: multiplier * 58.5, height: multiplier*104.05))
        
        self.multiplier = multiplier
        self.player = player
        
        // Add background phot
        imgView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        let bgImg = UIImage(named: "wwbg.png")
        imgView.image = bgImg
        addSubview(imgView)
        
        let dock = Dock(multiplier: multiplier)
        addSubview(dock)
        
        // Setup app display as collection view
        let layout = UICollectionViewFlowLayout()
        // Insets needed to place apps correct margin away from edges and from the dock
        // NOTE: These values assume multiplier = 5
        layout.sectionInset = UIEdgeInsets(top: 30, left: 10, bottom: 120, right: 10)
        layout.itemSize = CGSize(width: multiplier * 12, height: multiplier * 12)
        appCollection = UICollectionView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height), collectionViewLayout: layout)
        appCollection.register(AppCell.self, forCellWithReuseIdentifier: reuseId)
        appCollection.backgroundColor = UIColor.clear
        appCollection.isScrollEnabled = false
        
        appCollection.dataSource = self
        appCollection.delegate = self
        
        addSubview(appCollection)
        
        // Get time to setup status bar info
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none
        let timeString = dateFormatter.string(from: Date())
        
        let carrierTextView = UITextView(frame: CGRect(x: 0, y: -5, width: bounds.width, height: 50))
        carrierTextView.font = UIFont.systemFont(ofSize: 10)
        carrierTextView.backgroundColor = UIColor.clear
        carrierTextView.text = "Verizon \t\t\t  \(timeString)"
        carrierTextView.textColor = UIColor.white
        carrierTextView.isUserInteractionEnabled = false
        addSubview(carrierTextView)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // TODO: Evaluate if this is needed
    func openApp(index: Int) {
        switch index {
        case 0:
            // Do something
            break
        default:
            return
        }
    }
    
    func closeApp() {
        if appView != nil {
            UIView.transition(with: self, duration: 0.5, options: .transitionFlipFromBottom, animations: {
                self.appView?.removeFromSuperview()
            }, completion: { (status) in
                self.appView = nil
            })
        }
    }
}

extension Screen: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as! AppCell
        cell.backgroundColor = UIColor.green
        
        // Adjust dock apps only
        if(indexPath.section == 1) {
            switch indexPath.row {
            case 0:
                cell.textField.text = "R"
            case 1:
                cell.textField.text = "O"
            default:
                cell.textField.text = "S"
            }
        }
        return cell
    }
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        // First section is main app screen, second is dock
        return 2
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Only want 4 apps in the dock
        return section == 1 ? 4 : 16

    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.section == 0) {
            switch indexPath.row {
            case 0:
                appView = MapView(frame: bounds)
            case 1:
                appView = WebView(frame: bounds)
            case 2:
                appView = SettingsView(frame: bounds)
            case 3:
                appView = MusicPlayer(frame: bounds, player: player)
            default:
                break
            }
        }
        if let appView = appView as? SettingsView {
            appView.delegate = self
        }
        if let appView = appView {
            UIView.transition(with: self, duration: 0.5, options: .transitionFlipFromTop, animations: {
                self.addSubview(appView)
            }, completion: nil)
        }
    }
}

extension Screen: SettingsViewDelegate {
    public func changeColor(colorId: Int) {
        if let phone = superview as? Phone {
            let color = UIColor(netHex: hexArray[colorId])
            phone.updateColor(color: color)
            // Need to store new ID so slider can adjust when reloaded
            currColorId = colorId
        }
    }
    
    public func getCurrentColorId() -> Int {
        return currColorId
    }
}
