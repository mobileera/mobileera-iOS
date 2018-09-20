//
//  SpeakersDetailsViewController.swift
//  Mobile Era
//
//  Created by Konstantin Loginov on 21/05/2018.
//  Copyright © 2018 FotMob. All rights reserved.
//

import Foundation
import UIKit

class SpeakersDetailsViewController: BaseViewController {

    @IBAction func onTwitterCliked(_ sender: Any) {
        openUrl(speaker?.socials?.first(where: {$0.icon == "twitter"})?.link)
        
    }
    @IBAction func onGithubClicked(_ sender: Any) {
        openUrl(speaker?.socials?.first(where: {$0.icon == "github"})?.link)
        
    }
    @IBAction func onWebsiteClicked(_ sender: Any) {
        openUrl(speaker?.socials?.first(where: {$0.icon == "website"})?.link)
    }
    
    private func openUrl (_ link: String?) {
        guard let link = link, let url = URL(string: link) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCompany: UILabel!
    @IBOutlet weak var socialMediaStackView: UIStackView!
    @IBOutlet weak var btnTwitter: UIButton!
    @IBOutlet weak var btnGitHub: UIButton!
    @IBOutlet weak var btnWeb: UIButton!
    @IBOutlet weak var lblDescription: UILabel!
    
    private var speaker: Speaker?
    
    public init(speaker: Speaker) {
        super.init(nibName: "SpeakersDetailsViewController", bundle: nil)
        self.speaker = speaker
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
        imgAvatar.layer.cornerRadius = 8
        imgAvatar.clipsToBounds = true
        set(speaker: speaker)
    }
    
    public func set(speaker: Speaker?) {
        self.speaker = speaker
        
        guard let speaker = speaker else {
            lblName.text = ""
            lblCompany.text = ""
            lblDescription.text = ""
            imgAvatar.image = nil
            btnTwitter.isHidden = true
            btnGitHub.isHidden = true
            btnWeb.isHidden = true
            socialMediaStackView.isHidden = true
            return
        }
        
        lblName.text = speaker.name
        lblCompany.text = speaker.company
        if let url = URL(string: AppDelegate.domain + speaker.photoUrl) {
            imgAvatar.sd_setImage(with: url, completed: nil)
        }
        
        if let socials = speaker.socials {
            btnTwitter.isHidden = !socials.contains(where: {$0.icon == "twitter"})
            btnGitHub.isHidden = !socials.contains(where: {$0.icon == "github"})
            btnWeb.isHidden = !socials.contains(where: {$0.icon == "website"})
        } else {
            btnTwitter.isHidden = true
            btnGitHub.isHidden = true
            btnWeb.isHidden = true
        }
        
        socialMediaStackView.isHidden = btnTwitter.isHidden && btnGitHub.isHidden && btnWeb.isHidden
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2

        let descriptionText = NSMutableAttributedString (string: speaker.bio ?? "")
        descriptionText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSRange (location: 0, length: descriptionText.length))
        lblDescription.attributedText = descriptionText
    }

}
