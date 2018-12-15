//
//  AppDelegate.swift
//  Todoey
//
//  Created by Mohammad Mohaisen on 12/4/18.
//  Copyright © 2018 amjad Mohaisen. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //print(Realm.Configuration.defaultConfiguration.fileURL)

        
        do {
            _ = try Realm()

        } catch {
            print("Error initialising new realm , \(error)")
        }
        
        return true
    }
    

    
    // MARK: - Core Data stack
    

}

