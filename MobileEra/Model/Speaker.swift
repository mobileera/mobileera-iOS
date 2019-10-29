import Foundation

class Speaker: Codable {
    var id: String?
    var name: String = ""
    var photoUrl: String = ""
    var bio: String?
    var company: String?
    var country: String?
    var socials: [Social]?
}
