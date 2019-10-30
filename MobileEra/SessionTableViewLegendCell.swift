import UIKit

class SessionTableViewLegendCell: UITableViewCell {
    @IBOutlet weak var lblLegend: UILabel!
    @IBOutlet weak var felix1FixedColorBarView: FixedBackgroundView!
    @IBOutlet weak var felix2FixedColorBarView: FixedBackgroundView!
    @IBOutlet weak var lancingFixedColorBarView: FixedBackgroundView!

    override func awakeFromNib() {
        super.awakeFromNib()
        lblLegend.text = R.string.localizable.room() + ":"
        felix1FixedColorBarView.layer.cornerRadius = 2
        felix2FixedColorBarView.layer.cornerRadius = 2
        lancingFixedColorBarView.layer.cornerRadius = 2
        felix1FixedColorBarView.clipsToBounds = true
        felix2FixedColorBarView.clipsToBounds = true
        felix2FixedColorBarView.clipsToBounds = true
    }
    
    public static let key = "SessionTableViewLegendCell"
    public static let nib: UINib = UINib(nibName: key, bundle: Bundle.main)
    
}
