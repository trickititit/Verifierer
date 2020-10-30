//
//  TabBarController.swift
//  Verifierer
//
//  Created by Георгий Андреев on 21.10.2020.
//

import UIKit

class TabBarController: knTabController {
        override func setupView() {
            let home = knTabBarItem(icon: #imageLiteral(resourceName: "home"), title: "Домой", swapIcon: #imageLiteral(resourceName: "home_act"), font: UIFont(name: "Noto Sans Myanmar", size: 14)!)
            home.itemHeight = 70
            let scan = knTabBarItem(icon: #imageLiteral(resourceName: "scan"), title: "Сканировать", swapIcon: #imageLiteral(resourceName: "scan_act"), font: UIFont(name: "Noto Sans Myanmar", size: 14)!)
            scan.itemHeight = 70
            let profile = knTabBarItem(icon: #imageLiteral(resourceName: "profile"), title: "Профиль", swapIcon: #imageLiteral(resourceName: "profile_act"), font: UIFont(name: "Noto Sans Myanmar", size: 14)!)
            profile.itemHeight = 70
            
            let home_c = HomeViewController()
//            home_c.view.backgroundColor = .red
            let scan_c = MainViewController()
//            scan_c.view.backgroundColor = .green
            let profile_c = ProfileViewController()
//            profile_c.view.backgroundColor = .white
            
            setTabBar(items: [home, scan, profile])
            viewControllers = [home_c, scan_c, profile_c]
        }

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let vc1 = UIViewController()
//
//        let item1 = UITabBarItem()
//        item1.title = "Tabbar item"
//        item1.tag = 0
//
//        vc1.tabBarItem = item1
//
//
//        // inject custom tabbar
//        object_setClass(self.tabBar, TabBar.self)
//        (self.tabBar as! TabBar).setup()
    

//        let firstViewController = ProductViewController()
//
//        let item1 = UITabBarItem(tabBarSystemItem: .search, tag: 0)
//        item1.title = "Tabbar item"
////        item1.tag = 0
//
//        firstViewController.tabBarItem = item1
//
//        let secondViewController = MainViewController()
//
//        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
//
//        UITabBar.appearance().backgroundImage = UIImage()
//        UITabBar.appearance().shadowImage = UIImage()
//        UITabBar.appearance().clipsToBounds = false
//
//        let tabBarList = [firstViewController, secondViewController]
//
//        viewControllers = tabBarList
//
//
//        // inject custom tabbar
//        object_setClass(self.tabBar, TabBar.self)
//        (self.tabBar as! TabBar).setup()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
