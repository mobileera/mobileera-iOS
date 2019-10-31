import Foundation
import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .heavy), NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}
