//
//  SNColourPickerViewController.swift
//  Snippet
//
//  Created by Seb Vidal on 01/08/2022.
//

import Cocoa

class SNColourPickerViewController: NSViewController {
    private var hexTextField: NSTextField!
    
    weak var delegate: SNColourPickerDelegate?
    
    // MARK: loadView()
    override func loadView() {
        view = NSView(frame: NSRect(x: 0, y: 0, width: 282, height: 448))
    }
    
    // MARK: viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        _setupHexTextField()
    }
    
    private func _setupHexTextField() {
        
    }
}
