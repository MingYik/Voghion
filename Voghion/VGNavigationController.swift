//
//  VGNavigationController.swift
//  Voghion
//
//  Created by apple on 2023/4/26.
//

import UIKit

class VGNavigationController: UINavigationController {

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true;
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        if viewControllers.count > 0 {
            viewControllerToPresent.hidesBottomBarWhenPushed = true;
        }
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }

}
