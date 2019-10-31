import Foundation
import MapKit

struct MapAppLocation {
    var name: String
    var location: CLLocationCoordinate2D
}

protocol MapAppLoader: AnyObject {
    var title: String { get }
    func isSupported() -> Bool
    func openMap(at location: MapAppLocation)
}
