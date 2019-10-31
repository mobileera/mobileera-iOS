import Foundation
import UIKit
import Toaster
import MapKit

class VenueViewController: BaseViewController {
    private let venueLatitude = 59.910142
    private let venueLongitude = 10.725090
    private let partyLatitude = 59.9105716
    private let partyLongitude = 10.7262615

    lazy var venueMapView: MKMapView = {
        let mapView = MKMapView(frame: .zero)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()

    lazy var partyVenueMapView: MKMapView = {
        let mapView = MKMapView(frame: .zero)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = R.string.localizable.locations()
        view.backgroundColor = .white

        let spacing: CGFloat = 10.0
        let stackView = UIStackView(arrangedSubviews: [venueMapView, partyVenueMapView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = spacing
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: spacing),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -spacing),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: spacing),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -spacing)
        ])

        let venueLocation = CLLocationCoordinate2D(latitude: venueLatitude, longitude: venueLongitude)
        styleMap(mapView: venueMapView, location: venueLocation, title: "Conference\nFelix Conference Center\nBryggetorget 3\n0250 Oslo")

        let partyVenueLocation = CLLocationCoordinate2D(latitude: partyLatitude, longitude: partyLongitude)
        styleMap(mapView: partyVenueMapView, location: partyVenueLocation, title: "Party\nBeer Palace\nHolmens gate 3\n0250 Oslo")

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: R.image.info(), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(showInfo))
    }

    func styleMap(mapView: MKMapView, location: CLLocationCoordinate2D, title: String) {
        let distance = 100.0
        let venueRegion = MKCoordinateRegion(center: location, latitudinalMeters: distance, longitudinalMeters: distance)
        mapView.setRegion(venueRegion, animated: true)
        mapView.layer.cornerRadius = 16

        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = title
        mapView.addAnnotation(annotation)
    }

    @objc func showInfo() {
        let alertController = UIAlertController.infoAlert()
        present(alertController, animated: true, completion: nil)
    }
}
