import Foundation
import UIKit

open class Screen: UIView {
    
    let imgView = UIImageView()
    var appCollection: UICollectionView!
    var multiplier: CGFloat!
    
    let reuseId = "AppCell"
    
    public init(multiplier: CGFloat = 5) {
        super.init(frame: CGRect(x: multiplier * 4.31, y: multiplier * 17.12, width: multiplier * 58.5, height: multiplier*104.05))
        
        self.multiplier = multiplier
        
        // Add background phot
        imgView.frame = CGRect(x: 0, y: 10, width: frame.width, height: frame.height)
        let bgImg = UIImage(named: "bg3.png")
        imgView.image = bgImg
        addSubview(imgView)
        
        let dock = Dock(multiplier: multiplier)
        addSubview(dock)
        
        // Setup app display as collection view
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 40, left: 10, bottom: 100, right: 10)
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
        
        let carrierTextView = UITextView(frame: CGRect(x: 0, y: 5, width: bounds.width, height: 50))
        carrierTextView.font = UIFont.systemFont(ofSize: 10)
        carrierTextView.backgroundColor = UIColor.clear
        carrierTextView.text = "Verizon \t\t\t  \(timeString)"
        carrierTextView.textColor = UIColor.white
        carrierTextView.isEditable = false
        addSubview(carrierTextView)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func openApp(index: Int) {
        switch index {
        case 0:
            // Do something
            break
        default:
            return
        }
    }
}

extension Screen: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as! AppCell
        cell.backgroundColor = UIColor.red
        return cell
    }
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 1 ? 4 : 16

    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: Open app
    }
}
