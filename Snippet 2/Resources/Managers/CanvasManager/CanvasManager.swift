//
//  CanvasManager.swift
//  Snippet
//
//  Created by Seb Vidal on 20/07/2022.
//

import Cocoa

class CanvasManager {
    static var shared: SNCanvasView {
        let window = NSApp.windows.first
        let splitView = window?.contentViewController as? NSSplitViewController
        let item = splitView?.splitViewItems[1].viewController as? SNCanvasViewController

        return item!.canvasView
    }
    
    private init() {}
}
