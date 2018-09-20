//
//  SpeakerTableViewCell.swift
//  Mobile Era
//
//  Created by Konstantin Loginov on 15/05/2018.
//  Copyright © 2018 FotMob. All rights reserved.
//

import UIKit

class SpeakerTableViewCell: UICustomTableViewCell {
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCompany: UILabel!
    
    @IBOutlet weak var imgGithub: UIImageView!
    @IBOutlet weak var imgTwitter: UIImageView!
    @IBOutlet weak var imgWebsite: UIImageView!
    
    public static let key = "SpeakerTableViewCell"
    public static let nib: UINib = UINib(nibName: key, bundle: Bundle.main)
    
    private var session: Session?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgAvatar.layer.cornerRadius = 8
        imgAvatar.clipsToBounds = true
        imgAvatar.backgroundColor = R.color.separatorColor()
    }
    
    public func set(speaker: Speaker?) {
        guard let speaker = speaker else {
            lblName.text = ""
            lblCompany.text = ""
            imgAvatar.image = nil
            imgTwitter.isHidden = true
            imgGithub.isHidden = true
            imgWebsite.isHidden = true
            return
        }
        
        lblName.text = speaker.name
        lblCompany.text = speaker.company
        if let url = URL(string: AppDelegate.domain + speaker.photoUrl) {
            imgAvatar.sd_setImage(with: url, completed: nil)
        }
        
        if let socials = speaker.socials {
            imgTwitter.isHidden = !socials.contains(where: {$0.icon == "twitter"})
            imgGithub.isHidden = !socials.contains(where: {$0.icon == "github"})
            imgWebsite.isHidden = !socials.contains(where: {$0.icon == "website"})
        } else {
            imgTwitter.isHidden = true
            imgGithub.isHidden = true
            imgWebsite.isHidden = true
        }
    }
}
