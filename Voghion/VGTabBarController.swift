//
//  VGTabBarController.swift
//  Voghion
//
//  Created by apple on 2023/4/26.
//

import UIKit

class VGTabBarController: UITabBarController {

    override func viewDidLoad() {
        addChildViewControllers()
    }
    
    func addChildViewControllers(){
        setupChildVC(child: ViewController(), tilte: "Home", image: "home_tab_unsel", selImage: "home_tab_sel")
        setupChildVC(child: ProfileViewController(), tilte: "Category", image: "category_tab_unsel", selImage: "category_tab_sel")
        setupChildVC(child: ViewController(), tilte: "Me", image: "mine_tab_unsel", selImage: "mine_tab_sel")
        setupChildVC(child: VGPageVC(), tilte: "Cart", image: "cart_tab_unsel", selImage: "cart_tab_sel")
    }
    
    func setupChildVC(child: UIViewController, tilte: String, image: String, selImage: String) {
        let childNavi = UINavigationController.init(rootViewController: child)
        childNavi.tabBarItem.title = tilte
        childNavi.tabBarItem.image =  UIImage(named: image)!.withRenderingMode(.alwaysOriginal)
        childNavi.tabBarItem.selectedImage = UIImage(named: selImage)!.withRenderingMode(.alwaysOriginal)
        addChild(childNavi)
    }
    
    deinit {
        
    }

}
