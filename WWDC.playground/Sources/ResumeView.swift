import Foundation
import UIKit

open class ResumeView: UIView {
    var mainTextView: UITextView!
    var timer: Timer!
    var imageView: UIImageView!
    
    let textArray = ["Hello, world!", "My name is Ross", "I'm in my second of three years at NYU, where I study Computer Science", "While here I've built some pretty cool stuff", "I'm also on the executive board of a really cool club", "And I've worked at some pretty amazing companies", "I'd love to learn more and meet amazing people at WWDC 😊"]
    let imageArray = ["", "", "nyu.jpg", "nyudining.jpg", "tnyu.png", "ww.jpg", ""]
    var currCount = 0
    let animateDuration = 5.0
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = UIColor(red: 0.431, green: 0.231, blue: 0.604, alpha: 1.0)
        backgroundColor = UIColor(red: 0.286, green: 0.710, blue: 0.894, alpha: 1.00)
        
        timer = Timer.scheduledTimer(timeInterval: animateDuration + 1.0, target: self, selector: #selector(animate), userInfo: nil, repeats: true)
        
        imageView = UIImageView(frame: CGRect(x: frame.width/2 - 90, y: 190, width: 180, height: 180))
        imageView.contentMode = .scaleAspectFit
//        imageView.image = UIImage(named: "nyudining.jpg")
        
        let textFrame = CGRect(x: 0, y: 50, width: frame.width, height: 100)
        mainTextView = UITextView(frame: textFrame)
        mainTextView.backgroundColor = UIColor.clear
        mainTextView.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold)
//        mainTextView.text = "Hello, world!"
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
        
        if(currCount < imageArray.count) {
            let image = UIImage(named: imageArray[currCount])
            imageView.pushTransition(animateDuration)
            imageView.image = image
        }
        
        currCount += 1
        
        if(currCount >= textArray.count) {
            timer.invalidate()
        }
    }
}
