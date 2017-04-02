import Foundation
import UIKit

open class ResumeView: UIView {
    var mainTextView: UITextView!
    var timer: Timer!
    var imageView: UIImageView!
    
    let textArray = ["Hello, world!", "My name is Ross", "I'm in my second of three years at NYU, where I study Computer Science", "While here I've built some pretty cool things", "I'm also on the executive board of an amazing organization", "And I've worked at some great companies", "I'd love to learn more and meet amazing people at WWDC 😊"]
    let imageArray = ["", "pro_pic.jpg", "nyu.jpg", "nyudining.jpg", "tnyu.png", "ww.jpg", "hackny.jpg"]
    var currCount = 0
    let animateDuration = 4.5
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.286, green: 0.710, blue: 0.894, alpha: 1.00)
        
        timer = Timer.scheduledTimer(timeInterval: animateDuration + 1.0, target: self, selector: #selector(animate), userInfo: nil, repeats: true)
        
        // Image view should adjust to image aspect ratio
        imageView = UIImageView(frame: CGRect(x: 0, y: 190, width: frame.width, height: 300))
        imageView.contentMode = .scaleAspectFit
        
        let textFrame = CGRect(x: 0, y: 90, width: frame.width, height: 100)
        mainTextView = UITextView(frame: textFrame)
        mainTextView.backgroundColor = UIColor.clear
        mainTextView.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold)
        mainTextView.textAlignment = .center
       
        addSubview(imageView)
        addSubview(mainTextView)
        
        timer.fire()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func animate() {
        mainTextView.pushTransition(animateDuration)
        mainTextView.text = textArray[currCount]
        
        // Just in case there are fewer images than strings
        if(currCount < imageArray.count) {
            let image = UIImage(named: imageArray[currCount])
            imageView.imageTransition(animateDuration)
            imageView.image = image
        }
        
        currCount += 1
        
        if(currCount >= textArray.count) {
            // End timer once we complete every string
            timer.invalidate()
        }
    }
}
