//
//  SNNewPresetViewController.swift
//  Snippet
//
//  Created by Seb Vidal on 04/08/2022.
//

import Cocoa

class SNNewPresetViewController: NSViewController {
    override func loadView() {
        view = NSView(frame: NSRect(x: 0, y: 0, width: 640, height: 600))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        let window = view.window! as NSWindow
        window.preventsApplicationTerminationWhenModal = false
        window.styleMask.remove(.resizable)
    }
}
