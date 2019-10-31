import UIKit

class TabBarController: UITabBarController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)

        let scheduleTabBarItem = UITabBarItem(title: R.string.localizable.schedule(), image: R.image.schedule(), selectedImage: nil)
        let scheduleViewController = ScheduleViewController()
        let scheduleNavigationViewController = UINavigationController(rootViewController: scheduleViewController)
        scheduleNavigationViewController.navigationBar.backgroundColor = .white
        scheduleNavigationViewController.navigationBar.tintColor = R.color.primaryColor()
        scheduleNavigationViewController.tabBarItem = scheduleTabBarItem

        let speakersTabBarItem = UITabBarItem(title: R.string.localizable.speakers(), image: R.image.speaker(), selectedImage: nil)
        let speakersViewController = SpeakersViewController()
        let speakersNavigationViewController = UINavigationController(rootViewController: speakersViewController)
        speakersNavigationViewController.navigationBar.backgroundColor = .white
        speakersNavigationViewController.navigationBar.tintColor = R.color.primaryColor()
        speakersNavigationViewController.tabBarItem = speakersTabBarItem

        let venueTabBarItem = UITabBarItem(title: R.string.localizable.locations(), image: R.image.map(), selectedImage: nil)
        let venueViewController = VenueViewController()
        let venueNavigationViewController = UINavigationController(rootViewController: venueViewController)
        venueNavigationViewController.navigationBar.backgroundColor = .white
        venueNavigationViewController.navigationBar.tintColor = R.color.primaryColor()
        venueNavigationViewController.tabBarItem = venueTabBarItem

        viewControllers = [scheduleNavigationViewController, speakersNavigationViewController, venueNavigationViewController]

        tabBar.tintColor = R.color.primaryColor()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}
