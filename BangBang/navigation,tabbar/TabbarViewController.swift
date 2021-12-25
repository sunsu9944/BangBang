//
//  TabbarViewController.swift
//  BangBang
//
//  Created by 고준혁 on 2021/11/24.
//

import UIKit

class TabbarViewController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainVc = MainViewController()
        let favoriteVc = favoriteViewController()
        let traveledVc = traveledViewController()
        let UserVc = UserViewController()
        
        let home = UINavigationController(rootViewController: mainVc)
        let favorite = UINavigationController(rootViewController: favoriteVc)
        let traveled = UINavigationController(rootViewController: traveledVc)
        let User = UINavigationController(rootViewController: UserVc)
        setViewControllers([home,favorite,traveled,User], animated: true)

        home.tabBarItem = UITabBarItem(title: "Home", image: nil, tag: 0)
        favorite.tabBarItem = UITabBarItem(title: "찜", image: nil, tag: 1)
        traveled.tabBarItem = UITabBarItem(title: "여행 내역", image: nil, tag: 2)
        User.tabBarItem = UITabBarItem(title: "계정정보", image: nil, tag: 3)
        
        tabBar.tintColor = .white
        
        
        
        // Do any additional setup after loading the view.
    }
}

func tabbarAppearance(vc: UIViewController) { // tabbar
    let tabbarappearance = UITabBarAppearance()
    tabbarappearance.configureWithOpaqueBackground()
    tabbarappearance.backgroundColor = UIColor.init(red: 226/255, green: 226/255, blue: 249/255, alpha: 1)
    vc.tabBarController?.tabBar.standardAppearance = tabbarappearance
    vc.tabBarController?.tabBar.scrollEdgeAppearance = vc.tabBarController?.tabBar.standardAppearance
    
}
