//
//  IPstatusApp.swift
//  IPstatus
//
//  Created by Kemal Icecek on 31.07.2021.
//

import SwiftUI

@main
struct IPstatusApp: App {
    // Connecting App Delegate...
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        Settings {
            AnyView(_fromValue: self)
        }
    }
}


// Going to Build Menu Button and Pop Over Menu...
class AppDelegate: NSObject,NSApplicationDelegate {
    
    // Status Bar Item...
    var statusItem: NSStatusItem?
    // PopOver...
    var popOver = NSPopover()
    
    func applicationDidFinishLaunching(_ notification: Notification) {
    
        NetworkMonitor.shared.startMonitoring()
        //Menu View...
        let menuView = MenuView(localIP: getIPAdresses.getLocalIP(), publicIP: getIPAdresses.getPublicIP())
        
        // Creating PopOver...
        popOver.behavior = .transient
        popOver.animates = true
        // Setting Empty View Controller...
        // And Setting View as SwiftUI View...
        // with the help of Hosting Controller...
        popOver.contentViewController = NSViewController()
        popOver.contentViewController?.view = NSHostingView(rootView: menuView)
        
        // Also Makin View as Main View
        popOver.contentViewController?.view.window?.makeKey()
        // Creating Status Bar Button...
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        // Safe Check if status Button is Available or not...
        if let MenuButton = statusItem?.button{

            MenuButton.image =  NSImage(named: NSImage.Name("logo"))
//            MenuButton.image = NSImage(systemSymbolName: "icloud.and.arrow.up.fill", accessibilityDescription: nil)
            MenuButton.action = #selector(MenuButtonToggle)
        }
    }
    
    // Button Actioon...
    @objc func MenuButtonToggle(sender: AnyObject){
        
        // For Safer Side...
        if popOver.isShown{
            popOver.performClose(sender)
        }
        // Showing Popever...
        if let menuButton = statusItem?.button {
            
            // Top Get Button Localization For Popover Arrow...
            self.popOver.show(relativeTo: menuButton.bounds, of: menuButton, preferredEdge: NSRectEdge.minY)
        }
        

    }
}
