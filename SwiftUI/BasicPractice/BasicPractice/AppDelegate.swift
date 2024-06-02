//
//  AppDelegate.swift
//  SnapLens
//
//  Created by Vijay Pratap Singh on 31/03/24.
//

import UIKit
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure() // Configure Firebase
        return true
    }
    
}
