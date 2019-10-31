import Foundation
import UIKit
import Toaster
import MapKit

class VenueViewController: BaseViewController {
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
        title = R.string.localizable.location()

        let stackView = UIStackView(arrangedSubviews: [venueMapView, partyVenueMapView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    /*@IBOutlet weak var lblVenue: UILabel!
    @IBOutlet weak var lblParty: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var venueMapContainer: UIView!
    @IBOutlet weak var partyMapContainer: UIView!

    private let venueLatitude = 59.910142
    private let venueLongitude = 10.725090
    private let partyLatitude = 59.9105716
    private let partyLongitude = 10.7262615
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = R.string.localizable.venue()
        
        scrollView.contentInset = UIEdgeInsets.init(top: 15, left: 0, bottom: 15, right: 0)
        
        let venue = GMSCameraPosition.camera(withLatitude: venueLatitude, longitude: venueLongitude, zoom: 17.0)
        let party = GMSCameraPosition.camera(withLatitude: partyLatitude, longitude: partyLongitude, zoom: 17.0)

           let venueMapView = GMSMapView.map(withFrame: CGRect.zero, camera: venue)
           let partyMapView = GMSMapView.map(withFrame: CGRect.zero, camera: party)
        
        venueMapContainer.addSubview(venueMapView)
        partyMapContainer.addSubview(partyMapView)
        
        venueMapView.translatesAutoresizingMaskIntoConstraints = false
        venueMapView.isUserInteractionEnabled = false
        partyMapView.translatesAutoresizingMaskIntoConstraints = false
        partyMapView.isUserInteractionEnabled = false
        
        venueMapView.widthAnchor.constraint(equalTo: venueMapContainer.widthAnchor).isActive = true
        venueMapView.heightAnchor.constraint(equalTo: venueMapContainer.heightAnchor).isActive = true
        venueMapView.centerXAnchor.constraint(equalTo: venueMapContainer.centerXAnchor).isActive = true
        venueMapView.centerYAnchor.constraint(equalTo: venueMapContainer.centerYAnchor).isActive = true
        venueMapContainer.layer.cornerRadius = 8
        venueMapContainer.clipsToBounds = true
        partyMapView.widthAnchor.constraint(equalTo: partyMapContainer.widthAnchor).isActive = true
        partyMapView.heightAnchor.constraint(equalTo: partyMapContainer.heightAnchor).isActive = true
        partyMapView.centerXAnchor.constraint(equalTo: partyMapContainer.centerXAnchor).isActive = true
        partyMapView.centerYAnchor.constraint(equalTo: partyMapContainer.centerYAnchor).isActive = true
        partyMapContainer.layer.cornerRadius = 8
        partyMapContainer.clipsToBounds = true
        
        let venueMarker = GMSMarker()
        venueMarker.position = CLLocationCoordinate2D(latitude: venueLatitude, longitude: venueLongitude)
        venueMarker.title = "Felix Konferansesenter"
        venueMarker.map = venueMapView
        
        let partyMarker = GMSMarker()
        partyMarker.position = CLLocationCoordinate2D(latitude: partyLatitude, longitude: partyLongitude)
        partyMarker.title = "Beer Palace"
        partyMarker.map = partyMapView

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: R.image.info(), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(showInfo))
    }

    @objc func showInfo() {
        let alertController = UIAlertController.infoAlert()
        present(alertController, animated: true, completion: nil)
    }*/
}
