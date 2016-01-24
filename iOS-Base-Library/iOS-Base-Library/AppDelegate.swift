//
//  AppDelegate.swift
//  iOS-Base-Library
//
//  Created by Николай Ашанин on 23.01.16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import UIKit
import CocoaLumberjack

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var log: TILog?
    
    func application(application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
            
        self.initLog()
        
        return true
    }

    func initLog() -> Void {
        log = TILog.init()
        DDLogInfo(log!.startMessage())
    }

}
