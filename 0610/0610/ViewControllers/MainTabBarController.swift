//
//  MainTabBarController.swift
//  0610
//
//  Created by Chris on 2019/6/10.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import SwiftyJSON

enum MyViewControllerType: String {
    case viewController0 = "所有活動" // recent.json
    case viewController1 = "我的收藏"
    case viewController2 = "設定"
    case viewController3 = "自定義介面0" // course.json
    case viewController4 = "自定義介面1" // party.json
    case viewController5 = "自定義介面2" // popular.json
    case viewController6 = "自定義介面3" // hot.json
    case viewController7 = "自定義介面4" // marqueel.json
}

class MainTabBarController: UITabBarController {

    var myVCs: [Activity] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        getJSON()
    }

    func getJSON() {
        requestManager.getActivitys(success: { [weak self] (json) in
            log.info(json)

            let tintColorHex = json["tintColor"].stringValue
            self?.tabBar.tintColor = UIColor(hexString: tintColorHex)
            let tabBarColorHex = json["tabBarColor"].stringValue
            self?.tabBar.barTintColor = UIColor(hexString: tabBarColorHex)
            let unSelectedTabBarColorHex = json["unSelectedTabBarColor"].stringValue
            self?.tabBar.unselectedItemTintColor = UIColor(hexString: unSelectedTabBarColorHex)

            let list = json["list"].arrayValue
            for activity in list {
                let myVC = Activity(vc: activity["vc"].stringValue, img: activity["img"].stringValue, name: activity["name"].stringValue)
                self?.myVCs.append(myVC)
            }
            self?.setupTabBar()
        })
    }

    func setupTabBar() {
        var vcs = [UIViewController]()

        // If the number of view controllers is greater than the number displayable by a tab bar, a "More" navigation controller will automatically be shown.

        var count = myVCs.count
        if count > 5 {
            count = 5
        }

        for index in 0 ..< count {
            let myVC = myVCs[index]

            switch myVC.vc {
            case "ViewController0":
                let homeVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController

                homeVC.navigationItem.title = myVC.name

                let homeNav = UINavigationController.init(rootViewController: homeVC)
                homeNav.navigationBar.prefersLargeTitles = true
                homeNav.tabBarItem.image = UIImage(named: myVC.img)
                homeNav.tabBarItem.title = myVC.name

                vcs.append(homeNav)

            case "ViewController1":
                let collectiveVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CollectiveViewController") as! CollectiveViewController
                collectiveVC.navigationItem.title = myVC.name
                let collectiveNav = UINavigationController.init(rootViewController: collectiveVC)
                collectiveNav.tabBarItem.image = UIImage(named: myVC.img)
                collectiveNav.tabBarItem.title = myVC.name

                vcs.append(collectiveNav)

            case "ViewController2":
                let settingVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
                settingVC.navigationItem.title = myVC.name
                let settingNav = UINavigationController.init(rootViewController: settingVC)
                settingNav.tabBarItem.image = UIImage(named: myVC.img)
                settingNav.tabBarItem.title = myVC.name

                vcs.append(settingNav)

            default:
                let mixVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MIxViewController") as! MIxViewController

                switch myVC.vc {
                case "ViewController3":
                    mixVC.vcType = .viewController3
                case "ViewController4":
                    mixVC.vcType = .viewController4
                case "ViewController5":
                    mixVC.vcType = .viewController5
                case "ViewController6":
                    mixVC.vcType = .viewController6
                case "ViewController7":
                    mixVC.vcType = .viewController7
                default:
                    assertionFailure("wrong viewController name")
                    break
                }

                mixVC.navigationItem.title = myVC.name
                let mixNav = UINavigationController.init(rootViewController: mixVC)
                mixNav.tabBarItem.image = UIImage(named: myVC.img)
                mixNav.tabBarItem.title = myVC.name

                vcs.append(mixNav)
            }
        }

        self.setViewControllers(vcs, animated: false)
    }

}
