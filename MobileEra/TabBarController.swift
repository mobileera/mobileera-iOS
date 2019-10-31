import UIKit

class TabBarController: UITabBarController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)

        let scheduleTabBarItem = UITabBarItem(title: R.string.localizable.schedule(), image: R.image.schedule(), selectedImage: nil)
        let scheduleViewController = ScheduleViewController()
        let scheduleNavigationViewController = UINavigationController(rootViewController: scheduleViewController)
        scheduleNavigationViewController.navigationBar.backgroundColor = .white
        scheduleNavigationViewController.tabBarItem = scheduleTabBarItem

        let speakersTabBarItem = UITabBarItem(title: R.string.localizable.speakers(), image: R.image.speaker(), selectedImage: nil)
        let speakersViewController = SpeakersViewController()
        let speakersNavigationViewController = UINavigationController(rootViewController: speakersViewController)
        scheduleNavigationViewController.navigationBar.backgroundColor = .white
        speakersNavigationViewController.tabBarItem = speakersTabBarItem

        let venueTabBarItem = UITabBarItem(title: R.string.localizable.location(), image: R.image.map(), selectedImage: nil)
        let venueViewController = VenueViewController()
        let venueNavigationViewController = UINavigationController(rootViewController: venueViewController)
        scheduleNavigationViewController.navigationBar.backgroundColor = .white
        venueNavigationViewController.tabBarItem = venueTabBarItem

        viewControllers = [scheduleNavigationViewController, speakersNavigationViewController, venueNavigationViewController]

        tabBar.tintColor = R.color.primaryColor()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}
