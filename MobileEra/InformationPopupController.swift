//
//  InformationPopupController.swift
//  Mobile Era
//
//  Created by Konstantin Loginov on 21/05/2018.
//  Copyright © 2018 FotMob. All rights reserved.
//

import Foundation
import UIKit
import Toaster
import MessageUI

class InformationPopupController: UIViewController, UITextViewDelegate, MFMailComposeViewControllerDelegate {
    
    @IBAction func onDismissPopupClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var lblSponsors: UITextView!
    @IBOutlet weak var lblCodeOfConduct: UITextView!
    @IBOutlet weak var lblTeam: UITextView!
    @IBOutlet weak var lblContactUs: UITextView!
    
    @IBOutlet weak var lblCopyrights: UILabel!
    @IBOutlet weak var lblDeveloper: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewContainer.layer.cornerRadius = 8
        viewContainer.layer.borderColor = R.color.separatorColor()?.cgColor
        viewContainer.layer.borderWidth = 1
        viewContainer.clipsToBounds = true
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        paragraphStyle.alignment = .center
        
        let sponsorsString = NSMutableAttributedString(string: R.string.localizable.sponsors())
        sponsorsString.addAttributes([.link: "https://mobileera.rocks/",
                                      .paragraphStyle: paragraphStyle,
                                      .font: UIFont.systemFont(ofSize: 16, weight: .medium)], range: NSRange(location: 0, length: sponsorsString.length))
        lblSponsors.attributedText = sponsorsString
        lblSponsors.delegate = self
        
        let codeOfConductString = NSMutableAttributedString(string: R.string.localizable.codeofconduct())
        codeOfConductString.addAttributes([.link: "https://2017.mobileera.rocks/cod/", // we still don't have COD in 2018th 
                                      .paragraphStyle: paragraphStyle,
                                      .font: UIFont.systemFont(ofSize: 16, weight: .medium)], range: NSRange(location: 0, length: codeOfConductString.length))
        lblCodeOfConduct.attributedText = codeOfConductString
        
        let teamString = NSMutableAttributedString(string: R.string.localizable.mobileera_team())
        teamString.addAttributes([.link: "https://2018.mobileera.rocks/team/",
                                           .paragraphStyle: paragraphStyle,
                                           .font: UIFont.systemFont(ofSize: 16, weight: .medium)], range: NSRange(location: 0, length: teamString.length))
        lblTeam.attributedText = teamString
        lblTeam.delegate = self
        
        let contactUsString = NSMutableAttributedString(string: R.string.localizable.contact_us())
        contactUsString.addAttributes([.link: "contact@mobileera.rocks",
                                  .paragraphStyle: paragraphStyle,
                                  .font: UIFont.systemFont(ofSize: 16, weight: .medium)], range: NSRange(location: 0, length: contactUsString.length))
        lblContactUs.attributedText = contactUsString
        lblContactUs.delegate = self

        
        lblCopyrights.text = R.string.localizable.copirights()

        let developerString = NSMutableAttributedString(string: R.string.localizable.developer(R.string.localizable.developers_email()))
        developerString.addAttributes([.link: R.string.localizable.developers_email(),
                                  .paragraphStyle: paragraphStyle,
                                  .font: UIFont.systemFont(ofSize: 12, weight: .medium)], range: NSRange(location: 0, length: developerString.length))
        lblDeveloper.attributedText = developerString
        lblDeveloper.delegate = self
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if isValidEmail(URL.absoluteString) {
            if MFMailComposeViewController.canSendMail() {
                let mailController = MFMailComposeViewController ()
                mailController.mailComposeDelegate = self
                mailController.setToRecipients ([URL.absoluteString])
                present(mailController, animated: true, completion: nil)
            } else {
                Toast(text: R.string.localizable.cant_send_email(), duration: Delay.short).show()
            }

            return false
        }
        
        UIApplication.shared.open(URL, options: [:])
        return false
    }
    
    func isValidEmail(_ testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
}
