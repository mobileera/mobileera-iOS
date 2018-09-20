//
//  FirstViewController.swift
//  Mobile Era
//
//  Created by Konstantin Loginov on 22/04/2018.
//  Copyright © 2018 FotMob. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ScheduleViewController: BaseViewController {
    @IBAction func onSegmentControlValueChanged(_ sender: Any) {
        scheduleSource?.setSelectedDay(daySegmentControl.selectedSegmentIndex)
        tableView.reloadData()
    }
    
    @IBOutlet weak var daySegmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    private var filterBtn: UIBarButtonItem?
    private var scheduleSource: ScheduleSource?
    
    var database: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        database = Database.database().reference()
        database.keepSynced(true)
        
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
        
        daySegmentControl.setTitleTextAttributes([NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14, weight: .medium)], for: .normal)
        
        loadData()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: Notification.FILTER_NOTIFICATION), object: nil, queue: nil, using: { [weak self] _ in
            DispatchQueue.main.async {
                self?.scheduleSource?.doFilter()
                self?.tableView.reloadData()
                self?.updateFilterBadgeCount()
            }
        })
        
        createFilterButton()
        updateFilterBadgeCount()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    @objc func onFilterClicked() {
        performSegue(withIdentifier: "filterPopupSegue", sender: self)
    }
    
    public func createFilterButton() {
        let filterIcon = UIButton(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
        filterIcon.setImage(R.image.filter(), for: .normal)
        filterIcon.addTarget(self, action: #selector(onFilterClicked), for: .touchUpInside)
        
        let badge = UILabel(frame: CGRect(x: 14, y: -4, width: 16, height: 16))
        badge.layer.cornerRadius = badge.bounds.size.height / 2
        badge.textAlignment = .center
        badge.clipsToBounds = true
        badge.textColor = .white
        badge.font = UIFont.boldSystemFont(ofSize: 11)
        badge.backgroundColor = .red
        badge.tag = BADGE_TAG
        badge.isHidden = true
        filterIcon.addSubview(badge)
        
        filterBtn = UIBarButtonItem.init(customView: filterIcon)
        navigationItem.leftBarButtonItem = filterBtn
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
        
        database.observe(.value) { [weak self] (snapshot) in
            
            guard
                let speakersSnapshot = snapshot.childSnapshot(forPath: "speakers").value,
                let sessionsSnapshot = snapshot.childSnapshot(forPath: "sessions").value,
                let scheduleSnapshot = snapshot.childSnapshot(forPath: "schedule").value,
                
                JSONSerialization.isValidJSONObject(speakersSnapshot),
                JSONSerialization.isValidJSONObject(sessionsSnapshot),
                JSONSerialization.isValidJSONObject(scheduleSnapshot),
                
                let speakersData = try? JSONSerialization.data(withJSONObject: speakersSnapshot, options: []),
                let sessionsData = try? JSONSerialization.data(withJSONObject: sessionsSnapshot, options: []),
                let schedulesData = try? JSONSerialization.data(withJSONObject: scheduleSnapshot, options: []),
                
                let speakersDictionary = try? JSONDecoder().decode([String : Speaker].self, from: speakersData),
                let sessionsDictionary = try? JSONDecoder().decode([String: Session].self, from: sessionsData),
                let scheduleDictionary = try? JSONDecoder().decode([String: Day].self, from: schedulesData)
                
                else {
                    print("Error parsing data from Firebase")
                    return
            }
            
            for speaker in speakersDictionary {
                speaker.value.id = speaker.key
            }
            
            for session in sessionsDictionary {
                session.value.id = Int(session.key)
            }
            
            for day in scheduleDictionary {
                day.value.date = day.key
            }
            
            let speakers = Array(speakersDictionary.values)
            let sessions = Array(sessionsDictionary.values)
            var schedule = Array(scheduleDictionary.values)
            schedule.sort(by: { (d1, d2) -> Bool in
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
            
            for day in schedule {
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
            
            self?.scheduleSource?.setData(allSessions: sessions, schedule: schedule)
            self?.tableView.reloadData()
        }
    }
}

