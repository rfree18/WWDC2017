import Foundation

open class Track {
    var name: String?
    var previewUrl: String?
    var imageUrl: String?
    
    public init(json: [String: AnyObject]) {
        name = json["name"] as? String
        previewUrl = json["preview_url"] as? String
        if let album = json["album"] as? [String: AnyObject], let images = album["images"] as? [[String: AnyObject]] {
            let imageInfo = images[0]
            imageUrl = imageInfo["url"] as? String
        }
    }
}
