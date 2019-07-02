//
//  AppDelegate.swift
//  MXQRCode
//
//  Created by 贺靖 on 2019/6/25.
//  Copyright © 2019 贺靖. All rights reserved.
//

import UIKit
import SVProgressHUD
import GoogleMobileAds
import Bugly

let MainColor = UIColor.init(red: 137 / 255.0, green: 196 / 255.0, blue: 73 / 255.0, alpha: 1.0)

let TopHeight = UIApplication.shared.statusBarFrame.height + 44

let hasBang = UIApplication.shared.statusBarFrame.height > 0

//let BottomHeight = UIApplication.shared.

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow.init(frame: UIScreen.main.bounds)

        self.window?.backgroundColor = UIColor.white

        let mainVC = MainViewController()

        let nav = UINavigationController.init(rootViewController: mainVC)

        self.window?.rootViewController = nav

        self.setNav()
        
        self.setSVProgress()
        
        self.window?.makeKeyAndVisible()
        
        self.registerServices()
        
        return true
    }
    
    private func registerServices() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        Bugly.start(withAppId: "1a1d89d584")
    }
    
    private func setSVProgress() {
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.setMaximumDismissTimeInterval(1.5)
    }
    
    private func setNav() {
        //UINavigationBar* navigationBar = [UINavigationBar appearance];
        //// 17,45,141, 主色调颜色值
        //navigationBar.barTintColor = MainColor;
        //// 字体颜色
        //navigationBar.tintColor = [UIColor whiteColor];
        //[navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:15.0]}];
        // colorWithRed:17 / 255.0 green:45 / 255.0 blue:141 / 255.0 alpha:1
        let bar = UINavigationBar.appearance()
        bar.barTintColor = MainColor
        bar.tintColor = UIColor.white
        bar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.init(name: "Helvetica-Bold", size: 15.0)!];
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

