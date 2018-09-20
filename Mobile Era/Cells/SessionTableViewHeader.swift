//
//  SessionTableViewHeader.swift
//  Mobile Era
//
//  Created by Konstantin Loginov on 22/04/2018.
//  Copyright © 2018 FotMob. All rights reserved.
//

import UIKit

class SessionTableViewHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var separatorHeight: NSLayoutConstraint!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    public static let key = "SessionTableViewHeader"
    public static let nib: UINib = UINib(nibName: key, bundle: Bundle.main)
    
    public func set(timeslot: Timeslot?) {
        separatorHeight.constant = 0.5
        visualEffectView.effect = UIBlurEffect(style: .extraLight)
        
        if let startTime = timeslot?.startTime, let endTime = timeslot?.endTime {
            lblHeader.text = startTime + " - " + endTime
        } else {
            lblHeader.text = ""
        }
    }
}
