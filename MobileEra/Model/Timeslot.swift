//
//  Timeslot.swift
//  Mobile Era
//
//  Created by Konstantin Loginov on 22/04/2018.
//  Copyright © 2018 FotMob. All rights reserved.
//

import Foundation

class SessionItem: Codable {
    var items: [Int] = []
}

class Timeslot: Codable {

    var startTime: String = ""
    var endTime: String = ""
    var sessions: [SessionItem] = []
    var sessionsList: [Session]?

    init() {}
    init(startTime: String, endTime: String, sessionsList: [Session]?) {
        self.startTime = startTime
        self.endTime = endTime
        self.sessionsList = sessionsList
    }
}
