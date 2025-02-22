import UIKit
import Foundation
import SDWebImage

class SessionTableViewCell: UICustomTableViewCell {
    @IBOutlet weak var tagsStackView: UIStackView!
    @IBOutlet weak var separatorHeight: NSLayoutConstraint!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSpeaker: UILabel!
    @IBOutlet weak var lblRoomName: UILabel!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblExtraAvatarsCount: FixedBackgroundUILabel!
    @IBOutlet weak var btnStar: UIButton!
    @IBOutlet weak var colorBarView: UIView!
    @IBOutlet weak var imgAvatarContainer: UIView!
    @IBOutlet weak var bottomAvatarConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomSpeakerConstraint: NSLayoutConstraint!
    
    @IBAction func onStarClicked(_ sender: Any) {
        session?.toggleFavorites()
        btnStar.setImage(session?.isFavorite == true ? R.image.star_filled() : R.image.star(), for: .normal)
    }
    
    public static let key = "SessionTableViewCell"
    public static let nib: UINib = UINib(nibName: key, bundle: Bundle.main)
    
    private var session: Session?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        imgAvatarContainer.layer.cornerRadius = 8
        imgAvatarContainer.clipsToBounds = true
        
        lblExtraAvatarsCount.fixedBackgroundColor = R.color.primaryTextColor()
        lblExtraAvatarsCount.layer.cornerRadius = 2
        lblExtraAvatarsCount.clipsToBounds = true
    }

    public func set(session: Session?, track: Int) {
        self.session = session
        guard let session = session else { return }

        selectionStyle = session.isSystemAnnounce == true ? .none : .default

        var trackName: String = ""
        colorBarView.layer.backgroundColor = UIColor.clear.cgColor
        if session.isSystemAnnounce == false && session.isWorkshop == false {
            if track == 0 {
                colorBarView.layer.backgroundColor = R.color.felix1Color()?.cgColor
                trackName = "| Felix 1"
            } else if track == 1 {
                colorBarView.layer.backgroundColor = R.color.felix2Color()?.cgColor
                trackName = "| Felix 2"
            } else if track == 2 {
                colorBarView.layer.backgroundColor = R.color.lancingColor()?.cgColor
                trackName = "| Lancing"
            }
        }
        
        lblRoomName.text = trackName
        
        separatorHeight.constant = 0.5
        lblTitle.text = ""

        let text = session.title + (session.lightning == true ? " ⚡" : "")
        let attributedText = NSMutableAttributedString (string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange (location: 0, length: attributedText.length))
        lblTitle.attributedText = attributedText

        lblSpeaker.text = (session.speakersList?.map({$0.name}).joined(separator: ", "))
        
        if let speakersCount = session.speakers?.count, speakersCount > 1 {
            lblExtraAvatarsCount.isHidden = false
            lblExtraAvatarsCount.text = "+" + (speakersCount - 1).description
        } else {
            lblExtraAvatarsCount.isHidden = true
        }
        
        btnStar.isHidden = session.isSystemAnnounce == true
        btnStar.setImage(session.isFavorite == true ? R.image.star_filled() : R.image.star(), for: .normal)
        
        if let photoUrl = session.speakersList?.first?.photoUrl, let url = URL(string: AppDelegate.domain + photoUrl) {
            imgAvatar.sd_setImage(with: url, completed: nil)
        } else if let sessionUrl = session.image, let url = URL(string: AppDelegate.domain + sessionUrl) {
            imgAvatar.sd_setImage(with: url, completed: nil)
        } else {
            imgAvatar.image = nil
        }
        
        tagsStackView.subviews.forEach({$0.removeFromSuperview()})
        if let tags = session.tags {
            for tag in tags {
                let tagView = Tag.createTag(label: tag)
                tagsStackView.addArrangedSubview(tagView)
            }
        }
        
        let hasFooter = session.tags?.isEmpty == false || session.isSystemAnnounce == false
        
        bottomAvatarConstraint.constant = hasFooter ? 36 : 8
        bottomSpeakerConstraint.constant = hasFooter ? 36 : 8
    }
    
}
