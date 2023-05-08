//
//  VGAppearance.swift
//  Voghion
//
//  Created by apple on 2023/5/5.
//

import UIKit

open class VGAppearance {
    open class func configure() {
        tabBarConfig()
        naviBarConfig()
        fixOtherConfig()
        VGFullscreenPopGesture.configure()
    }
    
    open class func naviBarConfig() {
        if #available(iOS 13, *) {
            let naviBarAppearance = UINavigationBarAppearance()
            naviBarAppearance.shadowImage = UIColor.hexImage(0xffffff, 0)
            naviBarAppearance.backgroundImage = UIColor.hexImage(0xffffff, 0)
            UINavigationBar.appearance().standardAppearance = naviBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = naviBarAppearance
        }
    }
    open class func tabBarConfig() {
        let titleTextAttributes: [NSAttributedString.Key : Any] = [.foregroundColor: UIColor(0x666666), .font: UIFont.systemFont(ofSize: 10)]
        if #available(iOS 13, *) {
            let itemAppearance = UITabBarItemAppearance()
            itemAppearance.normal.titleTextAttributes = titleTextAttributes
            itemAppearance.selected.titleTextAttributes = titleTextAttributes
            itemAppearance.normal.badgeBackgroundColor = .clear
            itemAppearance.selected.badgeBackgroundColor = .clear
            let barAppearance = UITabBarAppearance()
            barAppearance.stackedLayoutAppearance = itemAppearance
            barAppearance.shadowImage = UIColor.hexImage(0xffffff, 0)
            barAppearance.backgroundImage = UIColor.hexImage(0xffffff, 0)
            // 官方文档写的是 重置背景和阴影为透明
            //barAppearance.configureWithTransparentBackground()
            UITabBar.appearance().standardAppearance = barAppearance
            if #available(iOS 15, *) {
                UITabBar.appearance().scrollEdgeAppearance = barAppearance
            }
        } else {
            UITabBarItem.appearance().badgeColor = .clear
            UITabBarItem.appearance().setBadgeTextAttributes(titleTextAttributes, for: .normal)
            UITabBarItem.appearance().setBadgeTextAttributes(titleTextAttributes, for: .selected)
            UITabBar.appearance().shadowImage = UIColor.hexImage(0xffffff, 0)
            UITabBar.appearance().backgroundImage = UIColor.hexImage(0xffffff, 0)
        }
    }
    
    open class func fixOtherConfig() {
        if #available(iOS 15, *) {
            UITableView.appearance().sectionHeaderTopPadding = 0
        }
    }
}
