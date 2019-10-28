//
//  SecondViewController.swift
//  Mobile Era
//
//  Created by Konstantin Loginov on 22/04/2018.
//  Copyright © 2018 FotMob. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseDatabase

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
    
    var database: DatabaseReference!
    
    private var speakersSource: SpeakersSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        database = Database.database().reference()
        database.keepSynced(true)
        
        title = R.string.localizable.speakers()
        
        speakersSource = SpeakersSource(self, speakers: [])
        tableView.dataSource = speakersSource
        tableView.delegate = speakersSource
        tableView.register(SpeakerTableViewCell.nib, forCellReuseIdentifier: SpeakerTableViewCell.key)
        tableView.contentInset = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
        
        loadData()
    }
    
    private func loadData() {
        database.observe(.value) { [weak self] (snapshot) in
            guard
                let speakersSnapshot = snapshot.childSnapshot(forPath: "speakers").value,
                JSONSerialization.isValidJSONObject(speakersSnapshot),
                let speakersData = try? JSONSerialization.data(withJSONObject: speakersSnapshot, options: []),
                let speakersDictionary = try? JSONDecoder().decode([String : Speaker].self, from: speakersData) else { return }

            for speaker in speakersDictionary {
                speaker.value.id = speaker.key
            }
            
            self?.speakersSource?.setData(Array(speakersDictionary.values))
            self?.tableView.reloadData()
        }
    }
}

