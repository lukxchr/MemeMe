//
//  AppDelegate.swift
//  MemeMe
//
//  Created by Lukasz Chrzanowski on 14/07/2015.
//  Copyright (c) 2015 ___LC___. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var memes = [Meme]()
    //let defaults = NSUserDefaults.standardUserDefaults()


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //testing nsuserdefaults
//        println("AppDelegate.application: \(defaults)")
//        if let storedValues = defaults.arrayForKey("values") as? [String] {
//            println("Stored values: \(storedValues)")
//            defaults.setObject(storedValues + ["new"], forKey: "values")
//        } else {
//            println("Failed to read stored values. Creating an instance...")
//            defaults.setObject(["val1"], forKey: "values")
//        }
        
//        if let storedMemes = defaults.arrayForKey("memes") as? [Meme] {
//            memes = storedMemes
//        } else {
//            println("No memes in memory")
//        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
//        println("applicationWillTerminate called")
//        if let storedMemes = defaults.arrayForKey("memes") as? [Meme] {
//            defaults.setObject(storedMemes + memes, forKey: "memes")
//            println("Saved memes.")
//        } else {
//            defaults.setObject(memes, forKey: "memes")
//            println("Created new object. Saved memes.")
//        }
        
    }


}

