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
        let homeViewController = SlangViewController()
        return homeViewController
    }()

    lazy var window: UIWindow = {
        let win = UIWindow(frame: UIScreen.mainScreen().bounds)
        win.backgroundColor = UIColor.whiteColor()
        win.rootViewController = UINavigationController(rootViewController: self.homeViewController)
        return win
    }()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        setup()
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: .Fade)
        window.makeKeyAndVisible()
        return true
    }

    func setup() {
        UITextField.appearance().tintColor = UIColor.whiteColor()
    }
}

