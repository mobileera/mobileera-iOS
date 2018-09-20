//
//  BaseViewController.swift
//  Mobile Era
//
//  Created by Konstantin Loginov on 15/05/2018.
//  Copyright © 2018 FotMob. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 16, weight: .heavy)]
    }
}
