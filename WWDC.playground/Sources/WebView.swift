import Foundation
import UIKit

open class WebView: UIView {
    var webView: UIWebView!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Disable cache since playgrounds throws nasty warning otherwise
        URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
        
        webView = UIWebView(frame: frame)
        let url = URL(string: "http://www.apple.com")!
        let request = URLRequest(url: url)
        webView.loadRequest(request)
        
        addSubview(webView)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
