//
//  SessionTableViewLegendCell.swift
//  Mobile Era
//
//  Created by Konstantin Loginov on 22/04/2018.
//  Copyright © 2018 FotMob. All rights reserved.
//

import UIKit

class SessionTableViewLegendCell: UITableViewCell {
    @IBOutlet weak var lblLegend: UILabel!
    @IBOutlet weak var odinFixedColorBarView: FixedBackgroundView!
    @IBOutlet weak var freyjaFixedColorBarView: FixedBackgroundView!
    @IBOutlet weak var thorFixedColorBarView: FixedBackgroundView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblLegend.text = R.string.localizable.room() + ":"
        odinFixedColorBarView.layer.cornerRadius = 2
        freyjaFixedColorBarView.layer.cornerRadius = 2
        thorFixedColorBarView.layer.cornerRadius = 2
        odinFixedColorBarView.clipsToBounds = true
        freyjaFixedColorBarView.clipsToBounds = true
        thorFixedColorBarView.clipsToBounds = true
    }
    
    public static let key = "SessionTableViewLegendCell"
    public static let nib: UINib = UINib(nibName: key, bundle: Bundle.main)
    
}
