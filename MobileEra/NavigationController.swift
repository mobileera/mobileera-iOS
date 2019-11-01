import UIKit

class NavigationController: UINavigationController {
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        navigationBar.backgroundColor = R.color.primaryColor()
        navigationBar.barTintColor = R.color.primaryColor()
        navigationBar.tintColor = .white
        navigationBar.isTranslucent = false
        navigationBar.setBackgroundImage(R.color.primaryColor()?.toImage(), for: .default)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
