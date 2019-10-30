import UIKit
import Foundation
import Firebase

extension Decodable {
    /// Initialize from JSON Dictionary. Return nil on failure
    init?(dictionary value: [String:Any]){
        
        guard JSONSerialization.isValidJSONObject(value) else { return nil }
        guard let jsonData = try? JSONSerialization.data(withJSONObject: value, options: []) else { return nil }
        
        guard let newValue = try? JSONDecoder().decode(Self.self, from: jsonData) else { return nil }
        self = newValue
    }
}

class SpeakersViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var database: Firestore!
    
    private var speakersSource: SpeakersSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let settings = FirestoreSettings()
        settings.isPersistenceEnabled = true
        database = Firestore.firestore()
        database.settings = settings

        title = R.string.localizable.speakers()
        
        speakersSource = SpeakersSource(self, speakers: [])
        tableView.dataSource = speakersSource
        tableView.delegate = speakersSource
        tableView.register(SpeakerTableViewCell.nib, forCellReuseIdentifier: SpeakerTableViewCell.key)
        tableView.contentInset = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
        
        loadData()
    }
    
    private func loadData() {
        database.collection("speakers").getDocuments { speakersQuerySnapshot, speakersError in
            let speakersDocuments = speakersQuerySnapshot?.documents ?? [QueryDocumentSnapshot]()
            var speakers = [Speaker]()
            for speakerDocument in speakersDocuments {
                guard let speakerData = try? JSONSerialization.data(withJSONObject: speakerDocument.data(), options: []) else { fatalError() }
                if let speaker = try? JSONDecoder().decode(Speaker.self, from: speakerData) {
                    speaker.id = speakerDocument.documentID
                    speakers.append(speaker)
                }
            }

            self.speakersSource?.setData(speakers)
            self.tableView.reloadData()
        }
    }
}

