import UIKit

class TabBarController: UITabBarController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)

        let scheduleTabBarItem = UITabBarItem(title: R.string.localizable.schedule(), image: R.image.schedule(), selectedImage: nil)
        let scheduleViewController = ScheduleViewController()
        let scheduleNavigationViewController = UINavigationController(rootViewController: scheduleViewController)
        scheduleNavigationViewController.navigationBar.backgroundColor = R.color.primaryColor()
        scheduleNavigationViewController.navigationBar.barTintColor = R.color.primaryColor()
        scheduleNavigationViewController.navigationBar.tintColor = .white
        scheduleNavigationViewController.navigationBar.isTranslucent = false
        scheduleNavigationViewController.navigationBar.setBackgroundImage(R.color.primaryColor()?.toImage(), for: .default)
        scheduleNavigationViewController.tabBarItem = scheduleTabBarItem

        let speakersTabBarItem = UITabBarItem(title: R.string.localizable.speakers(), image: R.image.speaker(), selectedImage: nil)
        let speakersViewController = SpeakersViewController()
        let speakersNavigationViewController = UINavigationController(rootViewController: speakersViewController)
        speakersNavigationViewController.navigationBar.backgroundColor = R.color.primaryColor()
        speakersNavigationViewController.navigationBar.barTintColor = R.color.primaryColor()
        speakersNavigationViewController.navigationBar.tintColor = .white
        speakersNavigationViewController.navigationBar.isTranslucent = false
        speakersNavigationViewController.navigationBar.setBackgroundImage(R.color.primaryColor()?.toImage(), for: .default)
        speakersNavigationViewController.tabBarItem = speakersTabBarItem

        let venueTabBarItem = UITabBarItem(title: R.string.localizable.locations(), image: R.image.map(), selectedImage: nil)
        let venueViewController = VenueViewController()
        let venueNavigationViewController = UINavigationController(rootViewController: venueViewController)
        venueNavigationViewController.navigationBar.backgroundColor = R.color.primaryColor()
        venueNavigationViewController.navigationBar.barTintColor = R.color.primaryColor()
        venueNavigationViewController.navigationBar.tintColor = .white
        venueNavigationViewController.navigationBar.isTranslucent = false
        venueNavigationViewController.navigationBar.setBackgroundImage(R.color.primaryColor()?.toImage(), for: .default)
        venueNavigationViewController.tabBarItem = venueTabBarItem

        viewControllers = [scheduleNavigationViewController, speakersNavigationViewController, venueNavigationViewController]
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = UIColor.black.withAlphaComponent(0.35)
        tabBar.barTintColor = R.color.primaryColor()
        tabBar.isTranslucent = false
        tabBar.backgroundColor = R.color.primaryColor()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}
