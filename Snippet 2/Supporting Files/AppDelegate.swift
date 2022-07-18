//
//  AppDelegate.swift
//  Snippet
//
//  Created by Seb Vidal on 23/06/2022.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    private var _window: NSWindow!
    private var _observer: NSKeyValueObservation!

    // MARK: ApplicationDidFinishLaunching
    func applicationDidFinishLaunching(_ notification: Notification) {
        let splitView = SNSplitViewController()
        
        _window = NSWindow(contentViewController: splitView)
        _window.styleMask = .defaultStyleMask
        _window.setFrame(.defaultWindowSize, display: true)
        _window.setFrameAutosaveName("MainWindow")
        _window.backgroundColor = .clear
        _window.makeKeyAndOrderFront(nil)
        
        _setupToolbar()
    }
    
    private func _setupToolbar() {
        ToolbarManager.shared.setupToolbar()
    }
    
    // MARK: ApplicationShouldTerminateAfterLastWindowClosed
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
