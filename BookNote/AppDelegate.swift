//
//  AppDelegate.swift
//  BookNote
//
//  Created by mac030 on 2024/06/18.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 탭바 컨트롤러 초기화
        let tabBarController = UITabBarController()
        
        // 탭바 아이템 설정
        let firstViewController = UIViewController()
        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        let secondViewController = UIViewController()
        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        let thirdViewController = UIViewController()
        thirdViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 2)
        let fourthViewController = UIViewController()
        fourthViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 3)
        
        // 탭바 컨트롤러에 뷰 컨트롤러들 추가
        tabBarController.viewControllers = [firstViewController, secondViewController, thirdViewController, fourthViewController]
        
        // 윈도우에 탭바 컨트롤러 설정
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }


    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
