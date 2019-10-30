import UIKit
import Firebase

class ScheduleViewController: BaseViewController {
    @IBAction func onSegmentControlValueChanged(_ sender: Any) {
        scheduleSource?.setSelectedDay(daySegmentControl.selectedSegmentIndex)
        tableView.reloadData()
    }
    
    @IBOutlet weak var daySegmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    private var filterBtn: UIBarButtonItem?
    private var scheduleSource: ScheduleSource?
    
    var database: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let settings = FirestoreSettings()
        settings.isPersistenceEnabled = true
        database = Firestore.firestore()
        database.settings = settings

        title = R.string.localizable.schedule()
        
        scheduleSource = ScheduleSource(self, selectedDay: daySegmentControl.selectedSegmentIndex)
        tableView.dataSource = scheduleSource
        tableView.delegate = scheduleSource
        tableView.register(SessionTableViewCell.nib, forCellReuseIdentifier: SessionTableViewCell.key)
        tableView.register(SessionTableViewLegendCell.nib, forCellReuseIdentifier: SessionTableViewLegendCell.key)
        tableView.register(SessionTableViewHeader.nib, forHeaderFooterViewReuseIdentifier: SessionTableViewHeader.key)
        tableView.isDirectionalLockEnabled = true
        tableView.separatorStyle = .none

        daySegmentControl.layer.borderColor = R.color.primaryColor()?.cgColor
        daySegmentControl.layer.cornerRadius = daySegmentControl.frame.height / 2
        daySegmentControl.layer.borderWidth = 1
        daySegmentControl.clipsToBounds = true
        
        daySegmentControl.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .medium)], for: .normal)
        
        loadData()

        updateFilterBadgeCount()

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: R.image.info(), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(showInfo))
    }

    @objc func showInfo() {
        let alertController = UIAlertController.infoAlert()        
        present(alertController, animated: true, completion: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

    private let BADGE_TAG = 24042018

    public func updateFilterBadgeCount() {
        guard let badge = (filterBtn?.customView?.subviews.first(where: {$0.tag == BADGE_TAG}) as? UILabel) else { return }
        
        let badgeCount = SettingsDataManager.instance.selectedTags.count + (SettingsDataManager.instance.showOnlyFavorite ? 1 : 0)
        badge.text = badgeCount.description
        badge.isHidden = badgeCount == 0
    }

    private func loadData() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

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

            self.database.collection("sessions").getDocuments() { sessionsQuerySnapshot, sessionsError in
                let sessionsDocuments = sessionsQuerySnapshot?.documents ?? [QueryDocumentSnapshot]()
                var sessions = [Session]()
                for sessionDocument in sessionsDocuments {
                    guard let sessionData = try? JSONSerialization.data(withJSONObject: sessionDocument.data(), options: []) else { fatalError() }
                    if let session = try? JSONDecoder().decode(Session.self, from: sessionData) {
                        session.id = Int(sessionDocument.documentID)
                        sessions.append(session)
                    }
                }

                self.database.collection("schedule").getDocuments() { schedulesQuerySnapshot, sessionsError in
                    let schedulesDocuments = schedulesQuerySnapshot?.documents ?? [QueryDocumentSnapshot]()
                    var schedules = [Day]()
                    for scheduleDocument in schedulesDocuments {
                        guard let scheduleData = try? JSONSerialization.data(withJSONObject: scheduleDocument.data(), options: []) else { fatalError() }
                        if let schedule = try? JSONDecoder().decode(Day.self, from: scheduleData) {
                            schedule.date = scheduleDocument.documentID
                            schedules.append(schedule)
                        }
                    }

                    schedules.sort(by: { (d1, d2) -> Bool in
                        if let d1Date = d1.date, let d2Date = d2.date {
                            return d1Date < d2Date
                        }

                        return false
                    })

                    var allTags: Set<String> = []
                    for session in sessions {
                        var joinedSpeakerList: [Speaker] = []

                        session.speakers?.forEach({ (id) in
                            if let joinedSpeaker = speakers.first(where: {$0.id == id}) {
                                joinedSpeakerList.append(joinedSpeaker)
                            }
                        })

                        session.speakersList = joinedSpeakerList
                        session.tags?.forEach({allTags.insert($0)})
                    }

                    for day in schedules {
                        for timeslot in day.timeslots {
                            var joinedSessionsList: [Session] = []
                            for id in timeslot.sessions.map({$0.items.first}) {
                                if let joinedSession = sessions.first(where: {$0.id == id}),
                                    let date = day.date {
                                    joinedSession.startDate = dateFormatter.date(from: date + "T" + timeslot.startTime)
                                    joinedSession.endDate = dateFormatter.date(from: date + "T" + timeslot.endTime)
                                    joinedSessionsList.append(joinedSession)
                                }
                            }

                            timeslot.sessionsList = joinedSessionsList
                        }
                    }

                    let manager = SettingsDataManager.instance
                    manager.allTags = Array(allTags)

                    self.scheduleSource?.setData(allSessions: sessions, schedule: schedules)
                    self.tableView.reloadData()
                }
            }
        }
    }
}

