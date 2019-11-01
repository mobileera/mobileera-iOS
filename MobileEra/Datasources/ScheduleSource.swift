import Foundation
import UIKit

class ScheduleSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[safe: section]?.sessionsList?.count ?? 0
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let session = data[safe: indexPath.section]?.sessionsList?[safe: indexPath.row]

        let speakersCount = session?.speakersList?.count ?? 0
        if speakersCount > 0 {
            return UITableView.automaticDimension
        } else {
            return 70
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let session = data[safe: indexPath.section]?.sessionsList?[safe: indexPath.row] {
            
            if session.isSystemAnnounce == true {
                return
            }
            
            vc?.navigationController?.pushViewController(SessionsDetailsViewController(session: session), animated: true)
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SessionTableViewHeader.key) as? SessionTableViewHeader {
            header.set(timeslot: data[safe: section])
            return header
        }
        
        return nil
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let session = data[safe: indexPath.section]?.sessionsList?[safe: indexPath.row]

        let speakersCount = session?.speakersList?.count ?? 0
        if speakersCount > 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: SessionTableViewCell.key) as? SessionTableViewCell {
                cell.set(session: session, track: indexPath.row)
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
            cell.textLabel?.text = session?.title
            return cell
        }

        return UITableViewCell()
    }

    private weak var vc: UIViewController?
    private var data: [Timeslot] = []
    public var allSessions: [Session] = []
    public var schedule: [Day] = []
    public var selectedDay: Int
    var isFelix1Selected = false
    var isFelix2Selected = false
    var isLancingSelected = false

    public init (_ vc: UIViewController, selectedDay: Int) {
        self.vc = vc
        self.selectedDay = selectedDay
    }

    public func setSelectedDay(_ day: Int) {
        self.selectedDay = day
        
        doFilter()
    }

    public func setSelectedFelix1(_ isSelected: Bool) {
        isFelix1Selected = isSelected
        doFilter()
    }

    public func setSelectedFelix2(_ isSelected: Bool) {
        isFelix2Selected = isSelected
        doFilter()
    }

    public func setSelectedLancing(_ isSelected: Bool) {
        isLancingSelected = isSelected
        doFilter()
    }

    public func setData(allSessions: [Session], schedule: [Day]) {
        self.allSessions = allSessions
        self.schedule = schedule
        
        doFilter()
    }

    public func doFilter() {
        data = []

        if let day = schedule[safe: selectedDay] {
            for timeslot in day.timeslots {
                var sessions =  [Session]()
                if isFelix1Selected {
                    if let session = timeslot.sessionsList?[safe: 0] {
                        if session.speakers?.count ?? 0 > 0 {
                            sessions.append(contentsOf: ([session]))
                        }
                    }
                }

                if isFelix2Selected {
                    if let session = timeslot.sessionsList?[safe: 1] {
                        if session.speakers?.count ?? 0 > 0 {
                            sessions.append(contentsOf: ([session]))
                        }
                    }
                }

                if isLancingSelected {
                    if let session = timeslot.sessionsList?[safe: 2] {
                        if session.speakers?.count ?? 0 > 0 {
                            sessions.append(contentsOf: ([session]))
                        }
                    }
                }

                if !isFelix1Selected && !isFelix2Selected && !isLancingSelected {
                    sessions = timeslot.sessionsList ?? [Session]()
                }

                if sessions.count > 0 {
                    let timeslot = Timeslot(
                        startTime: timeslot.startTime,
                        endTime: timeslot.endTime,
                        sessionsList: sessions)
                    data.append(timeslot)
                }
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
