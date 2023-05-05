//
//  VGTabBarController.swift
//  Voghion
//
//  Created by apple on 2023/4/26.
//

import UIKit

class VGTabBarController: UITabBarController {

    override func viewDidLoad() {
         barItemConfig()
         systemRemindStyle()
    }
    
    func barItemConfig(){
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor : UIColor(0x666666)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor : UIColor(0x666666)], for: .selected)
        tabBar.tintColor = UIColor(0x666666)
    }
    
    func systemRemindStyle(){
        let v1 = VGNavigationController.init(rootViewController: ViewController())
        let v2 = VGNavigationController.init(rootViewController: ProfileViewController())
        let v3 = VGNavigationController.init(rootViewController: VGPageVC())
        let v4 = VGNavigationController.init(rootViewController: ViewController())
    
        v1.tabBarItem = UITabBarItem.init(title: "Home", image: UIImage(named: "home_tab_unsel"), selectedImage: UIImage(named: "home_tab_sel")!.withRenderingMode(.alwaysOriginal))
        v2.tabBarItem = UITabBarItem.init(title: "Category", image: UIImage(named: "category_tab_unsel"), selectedImage: UIImage(named: "category_tab_sel")!.withRenderingMode(.alwaysOriginal))
        v3.tabBarItem = UITabBarItem.init(title: "Cart", image: UIImage(named: "cart_tab_unsel"), selectedImage: UIImage(named: "cart_tab_sel")!.withRenderingMode(.alwaysOriginal))
        v4.tabBarItem = UITabBarItem.init(title: "Me", image: UIImage(named: "mine_tab_unsel"), selectedImage: UIImage(named: "mine_tab_sel")!.withRenderingMode(.alwaysOriginal))
        viewControllers = [v1, v2, v3, v4]
    }
    
    deinit {
        
    }

}
