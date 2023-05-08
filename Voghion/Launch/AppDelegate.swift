//
//  AppDelegate.swift
//  Voghion
//
//  Created by apple on 2023/4/24.
//

import UIKit
import Kingfisher
import KingfisherWebP

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        preLaunchThirdParty()
        window = UIWindow(frame: UIScreen.main.bounds)
        let tabBarVC = VGTabBarController()
        window?.rootViewController = tabBarVC
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        deferLaunchThirdParty()
        return true
    }

    
    // MARK: -  Life Cycle
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
    
    // MARK: - Universal Links
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        return true
    }
    
    
    /// 9.0以后使用新监听app的回跳API
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return true
    }
    
    
    // MARK: - Push Notification
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
    }
    
    //MARK: - Third Party
    public func preLaunchThirdParty() {
        // 全局配置化
        VGAppearance.configure()
        // Kingfisher解码扩展
        let modifier = AnyModifier { request in
            var req = request
            req.addValue("image/gif */*", forHTTPHeaderField: "Accept")
            req.addValue("image/webp */*", forHTTPHeaderField: "Accept")
            return req
        }
        KingfisherManager.shared.defaultOptions += [
            .requestModifier(modifier),
            .processor(WebPProcessor.default),
            .cacheSerializer(WebPSerializer.default)
        ]

    }
    
    func deferLaunchThirdParty() {
        // 全局键盘控制
        //IQKeyboardManager.shared.enable = true
    }

}

