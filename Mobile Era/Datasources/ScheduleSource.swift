//
//  ScheduleSource.swift
//  Mobile Era
//
//  Created by Konstantin Loginov on 22/04/2018.
//  Copyright © 2018 FotMob. All rights reserved.
//

import Foundation
import UIKit

class ScheduleSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.numberOfSections == section + 1 && selectedDay != 0 {
            return 1
        }
        
        return data[safe: section]?.sessionsList?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count + (selectedDay == 0 ? 0 : 1)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if isLegend(section: section, in: tableView) {
            return 0
        }
        
        return 40
    }
    
    private func isLegend(section: Int, in tableView: UITableView) -> Bool {
        if selectedDay == 0 {
            return false
        }
        
        return tableView.numberOfSections == section + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let session = data[safe: indexPath.section]?.sessionsList?[safe: indexPath.row] {
            
            if session.isSystemAnnounce == true {
                return // system announces have nothing inside
            }
            
            vc?.navigationController?.pushViewController(SessionsDetailsViewController(session: session), animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if isLegend(section: section, in: tableView) {
            return nil
        }
        
        if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SessionTableViewHeader.key) as? SessionTableViewHeader {
            header.set(timeslot: data[safe: section])
            return header
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLegend(section: indexPath.section, in: tableView) {
            if let cell = tableView.dequeueReusableCell(withIdentifier: SessionTableViewLegendCell.key) as? SessionTableViewLegendCell {
                
                return cell
            }
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: SessionTableViewCell.key) as? SessionTableViewCell {
            cell.set(session: data[safe: indexPath.section]?.sessionsList?[safe: indexPath.row], track: indexPath.row)
            return cell
        }
        
        return UITableViewCell()
    }
    
    private weak var vc: UIViewController?
    private var data: [Timeslot] = []
    
    
    public var allSessions: [Session] = []
    public var schedule: [Day] = []
    public var selectedDay: Int
    
    public init (_ vc: UIViewController, selectedDay: Int) {
        self.vc = vc
        self.selectedDay = selectedDay
    }
    
    public func setSelectedDay(_ day: Int) {
        self.selectedDay = day
        
        doFilter()
    }
    
    public func setData(allSessions: [Session], schedule: [Day]) {
        self.allSessions = allSessions
        self.schedule = schedule
        
        doFilter()
    }
    
    public func doFilter() {
        // generating data
        
        data = []
        
        // workshop day
        if selectedDay == 0 {
            data = [Timeslot(startTime: "09:00", endTime: "16:00", sessionsList: allSessions.filter({$0.isWorkshop}))]
        } else if let day = schedule[safe: selectedDay - 1] {
            // conference days
            for timeslot in day.timeslots {
                data.append(Timeslot(startTime: timeslot.startTime, endTime: timeslot.endTime, sessionsList: timeslot.sessionsList?.filter({isMatchingFilter($0)})))
            }
        }
    }
    
    private func isMatchingFilter(_ session: Session) -> Bool {
        let showOnlyFavorite = SettingsDataManager.instance.showOnlyFavorite
        if showOnlyFavorite && !session.isFavorite {
            return false
        }
        
        let selectedTags = SettingsDataManager.instance.selectedTags
        if !selectedTags.isEmpty {
            return session.tags?.contains(where: {selectedTags.contains($0)}) ?? false
        }
        
        return true
    }
}
