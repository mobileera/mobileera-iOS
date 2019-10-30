import UIKit
import Foundation

class SessionsDetailsViewController: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tagsStackView: UIStackView!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var speakersTableView: UITableView!
    @IBOutlet weak var speakersTableHeightConstraint: NSLayoutConstraint!
    
    private var speakersSource: SpeakersSource?
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMMM d / HH:mm" // DateFormatter.dateFormat(fromTemplate: "MMMM d / HH:mm", options: 0, locale: Locale.current) ?? "MMMM d / HH:mm"
        return formatter
    }()
    
    private var session: Session?
    private var btnAddToFavorites: UIBarButtonItem?
    
    public init(session: Session) {
        super.init(nibName: "SessionsDetailsViewController", bundle: nil)
        self.session = session
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onAddToFavoritesClicked() {
        session?.toggleFavorites()
        (btnAddToFavorites?.customView as? UIButton)?.setImage(session?.isFavorite == true ? R.image.star_filled() : R.image.star(), for: .normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = ""

        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)

        let addToFavorites = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 22))
        addToFavorites.setImage(session?.isFavorite == true ? R.image.star_filled() : R.image.star(), for: .normal)
        addToFavorites.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        addToFavorites.addTarget(self, action: #selector(onAddToFavoritesClicked), for: .touchUpInside)
        
        btnAddToFavorites = UIBarButtonItem(customView: addToFavorites)
        navigationItem.rightBarButtonItem = btnAddToFavorites!
        
        if let speakers = session?.speakersList {
            speakersTableView.register(SpeakerTableViewCell.nib, forCellReuseIdentifier: SpeakerTableViewCell.key)
            speakersSource = SpeakersSource(self, speakers: speakers)
            speakersSource?.showIndex = false
            speakersTableView.dataSource = speakersSource
            speakersTableView.delegate = speakersSource
            speakersTableHeightConstraint.constant = CGFloat(speakers.count) * 76
        } else {
            speakersTableView.isHidden = true
        }
        
        setData()
    }

    private func setData() {
        guard let session = session else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2

        let titleText = NSMutableAttributedString (string: session.title)
        titleText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange (location: 0, length: titleText.length))
        lblTitle.attributedText = titleText
        
        let descriptionText = NSMutableAttributedString (string: session.description ?? "")
        descriptionText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange (location: 0, length: descriptionText.length))
        lblDescription.attributedText = descriptionText
        
        session.tags?.forEach({ tagsStackView.addArrangedSubview(Tag.createTag(label: $0, clickable: false))})
        
        lblSubtitle.text = session.language
        if let startDate = session.startDate, let language = session.language {
            lblSubtitle.text = String(format: "%@ / %@", dateFormatter.string(from: startDate).capitalized, language)
        }
    }
}

