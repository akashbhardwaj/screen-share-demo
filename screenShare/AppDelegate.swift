//
//  AppDelegate.swift
//  screenShare
//
//  Created by Akash Bhardwaj on 05/10/18.
//  Copyright © 2018 Akash Bhardwaj. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    func applicationDidChangeScreenParameters(_ notification: Notification) {
        print("Screen Changed")
    }
}

