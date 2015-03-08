//
//  AppDelegate.swift
//  Slang
//
//  Created by Tosin Afolabi on 02/01/2015.
//  Copyright (c) 2015 Tosin Afolabi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var homeViewController: UIViewController = {
        let homeViewController = LessonListViewController()
        return homeViewController
    }()

    lazy var window: UIWindow = {
        let win = UIWindow(frame: UIScreen.mainScreen().bounds)
        win.backgroundColor = UIColor.blackColor()
        win.rootViewController = UINavigationController(rootViewController:self.homeViewController)
        return win
    }()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        setup()
        window.makeKeyAndVisible()
        return true
    }

    func setup() {
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: .Fade)
        //UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
        UINavigationBar.appearance().translucent = false
        UINavigationBar.appearance().barTintColor = UIColor.PrimaryBrandColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        UITextField.appearance().tintColor = UIColor.whiteColor()
    }
}

