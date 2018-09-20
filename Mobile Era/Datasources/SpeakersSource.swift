//
//  SpeakersSource.swift
//  Mobile Era
//
//  Created by Konstantin Loginov on 15/05/2018.
//  Copyright © 2018 FotMob. All rights reserved.
//

import Foundation
import UIKit

class SpeakersSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    public var speakers: [[Speaker]] = []
    public var index: [String] = []
    public var showIndex: Bool = true
    
    private weak var vc: UIViewController?
    
    public init (_ vc: UIViewController, speakers: [Speaker]) {
        super.init()
        self.vc = vc
        setData(speakers)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return index.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return speakers[section].count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let speaker = speakers[safe: indexPath.section]?[safe: indexPath.row] {
             vc?.navigationController?.pushViewController(SpeakersDetailsViewController(speaker: speaker), animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if showIndex {
            return index
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: SpeakerTableViewCell.key) as? SpeakerTableViewCell {
            cell.set(speaker: speakers[indexPath.section][safe: indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    public func setData(_ speakers: [Speaker]) {
        var speakersIndex: [String: [Speaker]] = [:]
        
        for speaker in speakers {
            if let initials = speaker.name.first?.description {
                if speakersIndex[initials] == nil {
                    speakersIndex[initials] = []
                }
                
                speakersIndex[initials]?.append(speaker)
            }
        }
        
        let sortedSpeakersIndex = speakersIndex.sorted(by: {$0.key < $1.key})
        
        self.index = sortedSpeakersIndex.map({$0.key})
        self.speakers = sortedSpeakersIndex.map({$0.value})
    }
}

