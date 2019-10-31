import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    public static let domain = "https://mobileera.rocks"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.tintColor = R.color.primaryColor()
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()

        return true
    }
}
