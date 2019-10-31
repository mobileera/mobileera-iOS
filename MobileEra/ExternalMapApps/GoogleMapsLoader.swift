import UIKit

class GoogleMapsLoader: MapAppLoader {
    private let googleMapsScheme = "comgooglemapsurl://"
    let title = "Google Maps"

    func isSupported() -> Bool {
        guard let url = URL(string: googleMapsScheme) else {
            return false
        }
        return UIApplication.shared.canOpenURL(url)
    }

    func openMap(at location: MapAppLocation) {
        guard let url = URL(string: googleMapsScheme + "maps.google.com/maps/search/?api=1&query=\(location.location.latitude),\(location.location.longitude)") else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
