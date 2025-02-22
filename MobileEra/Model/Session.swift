import Foundation

class Session: Codable {
    
    private static let KEY_FAVORITE_SESSION: String = "KEY_FAVORITE_SESSION_"
    
    var id: Int?
    var title: String = ""
    var description: String?
    var image: String?
    var language: String?
    var lightning: Bool?
    var speakers: [String]?
    var speakersList: [Speaker]?
    var tags: [String]?
    var price: String?
    
    var startDate: Date?
    var endDate: Date?
    var duration: TimeInterval {
        guard let startDate = startDate, let endDate = endDate else { return 0 }
        return endDate.timeIntervalSince(startDate)
    }
    
    var isWorkshop: Bool {
        guard let id = id else { return false }
        return id >= 200 && id < 300
    }
    
    var isSystemAnnounce: Bool {
        let count = speakers?.count ?? 0
        return count == 0
    }
    
    var isFavorite: Bool {
        guard let id = id else { return false }
        if isSystemAnnounce {
            return false // lunch, system announce, etc.
        }
        
        return UserDefaults.standard.bool (forKey: Session.KEY_FAVORITE_SESSION + id.description)
    }
    
    func toggleFavorites() {
        guard let id = id else { return }
        if isSystemAnnounce {
            return
        }
        
        let oldValue = isFavorite
        UserDefaults.standard.set(!oldValue, forKey: Session.KEY_FAVORITE_SESSION + id.description)
    }
}
