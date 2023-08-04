//
//  AppDelegate.swift
//  NeuroIdExample
//
//  Created by Ky Nguyen on 7/1/21.
//

import UIKit
import Neuro_ID

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        NeuroID.configure(clientKey: "YOUR_KEY")
        NeuroID.setEnvironmentProduction(true)
        NeuroID.setSiteId(siteId: "YOUR_SITE_ID")
        NeuroID.start();
        NeuroID.getClientID()
        let user = ProcessInfo.processInfo.environment["USER_ID"] ?? "nid_ios_swiftyzzz"
        NeuroID.setUserID(user)
        // resume() is called in case stop() was called in a previous build.
        // the local stroage will still have stop indicator in it unless resume is called.
        
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

