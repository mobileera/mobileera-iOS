import Foundation
import UIKit

public class UICustomTableViewCell: UITableViewCell {
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
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
