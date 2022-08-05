//
//  SNSplitViewController.swift
//  Snippet
//
//  Created by Seb Vidal on 23/06/2022.
//

import Cocoa

class SNSplitViewController: NSSplitViewController {
    var emptyViewController: SNEmptyViewController!
    var canvasViewController: SNCanvasViewController!
    var settingsViewController: SNSettingsViewController!

    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        _setupSplitViewItems()
    }
    
    private func _setupSplitViewItems() {
        emptyViewController = SNEmptyViewController()
        canvasViewController = SNCanvasViewController()
        settingsViewController = SNSettingsViewController()
        
        let emptyItem = NSSplitViewItem(sidebarWithViewController: emptyViewController)
        emptyItem.collapseBehavior = .useConstraints
        emptyItem.isCollapsed = true
        
        let canvasItem = NSSplitViewItem(contentListWithViewController: canvasViewController)
        canvasItem.collapseBehavior = .useConstraints
        canvasItem.canCollapse = false
        
        let settingsItem = NSSplitViewItem(sidebarWithViewController: settingsViewController)
        settingsItem.collapseBehavior = .useConstraints
        
        addSplitViewItem(emptyItem)
        addSplitViewItem(canvasItem)
        addSplitViewItem(settingsItem)
    }
    
    // MARK: viewDidAppear
    override func viewDidAppear() {
        super.viewDidAppear()
        _handleFirstLaunch()
    }
    
    private func _handleFirstLaunch() {
        if !UserDefaults.standard.keyExists(key: "hasLaunchedBefore") {
            let welcomeViewController = SNWelcomeViewController()
            view.window?.preventsApplicationTerminationWhenModal = false
            view.window?.contentViewController?.presentAsSheet(welcomeViewController)
        }
    }
    
    // MARK: splitViewDidResizeSubviews
    override func splitViewDidResizeSubviews(_ notification: Notification) {
        if let settingsItem = splitViewItems.last {
            if settingsItem.isCollapsed {
                ToolbarManager.shared.removeTabItems(withDelay: 0)
            } else {
                guard let _ = NSApp.windows.first else {
                    return
                }
                
                ToolbarManager.shared.insertTabItems(withDelay: 0)
            }
        }
    }
}
