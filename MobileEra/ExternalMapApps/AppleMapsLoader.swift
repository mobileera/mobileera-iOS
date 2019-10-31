import MapKit

class AppleMapsLoader: MapAppLoader {
    let title = "Map"

    func isSupported() -> Bool {
        return true
    }

    func openMap(at location: MapAppLocation) {
        let placemark = MKPlacemark(coordinate: location.location, addressDictionary: nil)
        let destination = MKMapItem(placemark: placemark)
        destination.name = location.name
        MKMapItem.openMaps(with: [destination], launchOptions: nil)
    }
}
