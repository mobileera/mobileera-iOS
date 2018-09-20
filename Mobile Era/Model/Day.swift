//
//  Day.swift
//  Mobile Era
//
//  Created by Konstantin Loginov on 22/04/2018.
//  Copyright © 2018 FotMob. All rights reserved.
//

import Foundation

class Day: Codable {
    var date: String?
    var dateReadable: String = ""
    var timeslots: [Timeslot] = []
}
