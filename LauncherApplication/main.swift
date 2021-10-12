//
//  main.swift
//  LauncherApplication
//
//  Created by Kemal Icecek on 5.08.2021.
//

import Cocoa

let delegate = LauncherApplicationAppDelegate()
NSApplication.shared.delegate = delegate
_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
