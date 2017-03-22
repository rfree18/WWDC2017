import Foundation
import UIKit
import MapKit

open class MapView: UIView {
    var map: MKMapView!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        map = MKMapView(frame: frame)
        let initialLocation = CLLocation(latitude: 37.329008, longitude: -121.8909876)
        let regionRadius:CLLocationDistance = 1000
        let region = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        map.setRegion(region, animated: true)
        
        addSubview(map)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
