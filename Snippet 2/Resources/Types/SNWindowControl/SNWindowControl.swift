//
//  SNWindowControl.swift
//  Snippet
//
//  Created by Seb Vidal on 18/07/2022.
//

import Cocoa

class SNWindowControl: NSView {
    var controlType: ControlType = .close {
        didSet {
            _updateControlType()
        }
    }
    
    var colourScheme: ControlColourScheme = .colourful {
        didSet {
            
        }
    }
    
    var showsSymbols: Bool = false {
        didSet {
            
        }
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        _setupControlView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _setupControlView() {
        wantsLayer = true
        layer?.cornerRadius = 6
        layer?.masksToBounds = true
        layer?.cornerCurve = .circular
    }
    
    private func _updateControlType() {
        let name = "\(controlType.rawValue)Control"
        layer?.backgroundColor = NSColor(named: name)?.cgColor
    }
    
    override var intrinsicContentSize: NSSize {
        return NSSize(width: 12, height: 12)
    }
}

extension SNWindowControl {
    enum ControlColourScheme {
        case colourful
        case graphite
        case none
    }
    
    enum ControlType: String {
        case close = "Close"
        case minimise = "Minimise"
        case restore = "Restore"
    }
}
