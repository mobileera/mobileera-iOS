import UIKit

class TabBarController: UITabBarController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)

        tabBar.tintColor = R.color.primaryColor()
        tabBar.barTintColor = .white
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .white

        let scheduleTabBarItem = UITabBarItem(title: R.string.localizable.schedule(), image: R.image.schedule(), selectedImage: nil)
        let scheduleViewController = ScheduleViewController()
        let scheduleNavigationViewController = NavigationController(rootViewController: scheduleViewController)
        scheduleNavigationViewController.tabBarItem = scheduleTabBarItem

        let speakersTabBarItem = UITabBarItem(title: R.string.localizable.speakers(), image: R.image.speaker(), selectedImage: nil)
        let speakersViewController = SpeakersViewController()
        let speakersNavigationViewController = NavigationController(rootViewController: speakersViewController)
        speakersNavigationViewController.tabBarItem = speakersTabBarItem

        let venueTabBarItem = UITabBarItem(title: R.string.localizable.locations(), image: R.image.map(), selectedImage: nil)
        let venueViewController = VenueViewController()
        let venueNavigationViewController = NavigationController(rootViewController: venueViewController)
        venueNavigationViewController.tabBarItem = venueTabBarItem

        viewControllers = [scheduleNavigationViewController, speakersNavigationViewController, venueNavigationViewController]
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}
