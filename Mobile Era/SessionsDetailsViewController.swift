//
//  SessionsDetailsViewController.swift
//  Mobile Era
//
//  Created by Konstantin Loginov on 22/04/2018.
//  Copyright © 2018 FotMob. All rights reserved.
//

import UIKit
import Foundation
import EventKit
import EventKitUI

class SessionsDetailsViewController: BaseViewController, EKEventEditViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tagsStackView: UIStackView!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var speakersTableView: UITableView!
    @IBOutlet weak var speakersTableHeightConstraint: NSLayoutConstraint!
    
    private var speakersSource: SpeakersSource?
    
    private lazy var eventController: EKEventEditViewController = {
        let controller = EKEventEditViewController()
        controller.eventStore = eventStore
        controller.editViewDelegate = self
        return controller
    }()
    
    private lazy var eventStore: EKEventStore = {
        return EKEventStore()
    }()
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMMM d / HH:mm" // DateFormatter.dateFormat(fromTemplate: "MMMM d / HH:mm", options: 0, locale: Locale.current) ?? "MMMM d / HH:mm"
        return formatter
    }()
    
    private var session: Session?
    private var btnAddToCalendar, btnAddToFavorites: UIBarButtonItem?
    
    public init(session: Session) {
        super.init(nibName: "SessionsDetailsViewController", bundle: nil)
        self.session = session
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onAddToFavoritesClicked() {
        session?.toggleFavorites()
        (btnAddToFavorites?.customView as? UIButton)?.setImage(session?.isFavorite == true ? R.image.removeFromFavorites() : R.image.addToFavorites(), for: .normal)
    }
    
    @objc func onAddToCalendarClicked() {
        eventStore.requestAccess(to: .event) { [weak self] (granted, e) in
            if !granted || e != nil {
                print("An error occured: can't add event to the calendar")
                return
            }
            
            self?.addSessionToCalendar()
        }
    }
    
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func addSessionToCalendar() {
        guard let session = session, let startDate = session.startDate else { return }
        
        let event = EKEvent(eventStore: eventStore)
        // set the alarm for 5 minutes from now
        event.addAlarm(EKAlarm(absoluteDate: startDate.addingTimeInterval(-5 * 60)))

        event.startDate = startDate
        event.calendar = eventStore.defaultCalendarForNewEvents
        event.endDate = startDate.addingTimeInterval(session.duration)
        event.title = session.title
        
        eventController.event = event
        present(eventController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ""

        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
        
        let addToCalendar = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 22))
        addToCalendar.setImage(R.image.addToCalendar(), for: .normal)
        addToCalendar.addTarget(self, action: #selector(onAddToCalendarClicked), for: .touchUpInside)

        let addToFavorites = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 22))
        addToFavorites.setImage(session?.isFavorite == true ? R.image.removeFromFavorites() : R.image.addToFavorites(), for: .normal)
        addToFavorites.addTarget(self, action: #selector(onAddToFavoritesClicked), for: .touchUpInside)
        
        btnAddToCalendar = UIBarButtonItem(customView: addToCalendar)
        btnAddToFavorites = UIBarButtonItem(customView: addToFavorites)

        navigationItem.rightBarButtonItems = [btnAddToCalendar!, btnAddToFavorites!]
        
        if let speakers = session?.speakersList {
            speakersTableView.register(SpeakerTableViewCell.nib, forCellReuseIdentifier: SpeakerTableViewCell.key)
            speakersSource = SpeakersSource(self, speakers: speakers)
            speakersSource?.showIndex = false
            speakersTableView.dataSource = speakersSource
            speakersTableView.delegate = speakersSource
            speakersTableHeightConstraint.constant = CGFloat(speakers.count) * 76
        } else {
            speakersTableView.isHidden = true
        }
        
        setData()
    }

    private func setData() {
        guard let session = session else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2

        let titleText = NSMutableAttributedString (string: session.title)
        titleText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSRange (location: 0, length: titleText.length))
        lblTitle.attributedText = titleText
        
        let descriptionText = NSMutableAttributedString (string: session.description ?? "")
        descriptionText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSRange (location: 0, length: descriptionText.length))
        lblDescription.attributedText = descriptionText
        
        session.tags?.forEach({ tagsStackView.addArrangedSubview(Tag.createTag(label: $0, clickable: false))})
        
        lblSubtitle.text = session.language
        if let startDate = session.startDate, let language = session.language {
            lblSubtitle.text = String(format: "%@ / %@", dateFormatter.string(from: startDate).capitalized, language)
        }
    }
}

