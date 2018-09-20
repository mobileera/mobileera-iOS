//
//  UICustomTableViewCell.swift
//  Mobile Era
//
//  Created by Konstantin Loginov on 22/04/2018.
//  Copyright © 2018 FotMob. All rights reserved.
//

import Foundation
import UIKit

public class UICustomTableViewCell: UITableViewCell {
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setDefaultSelection()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setDefaultSelection()
    }
    
    public func setDefaultSelection() {
        selectionStyle = .default
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = R.color.selectionColor()
    }
}
