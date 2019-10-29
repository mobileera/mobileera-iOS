import Foundation

class Day: Codable {
    var date: String?
    var dateReadable: String = ""
    var timeslots: [Timeslot] = []
}
