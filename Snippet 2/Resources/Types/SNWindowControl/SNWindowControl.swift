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
            _updateControlColourScheme()
        }
    }
    
    override var intrinsicContentSize: NSSize {
        return NSSize(width: 12, height: 12)
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
        layer?.borderWidth = 0.5
        layer?.cornerRadius = 6
        layer?.masksToBounds = true
        layer?.cornerCurve = .circular
    }
    
    private func _updateControlType() {
        NSAppearance.current(in: self).performAsCurrentDrawingAppearance {
            let name = controlType.rawValue
            backgroundColour = NSColor(named: "\(name)Control")
            layer?.borderColor = NSColor(named: "\(name)Border")?.cgColor
        }
    }
    
    private func _updateControlColourScheme() {
        NSAppearance.current(in: self).performAsCurrentDrawingAppearance {
            switch colourScheme {
            case .colourful:
                let name = controlType.rawValue
                backgroundColour = NSColor(named: "\(name)Control")
                layer?.borderColor = NSColor(named: "\(name)Border")?.cgColor
                alphaValue = 1
            case .graphite:
                let name = "GraphiteControl"
                backgroundColour = NSColor(named: name)
                layer?.borderColor = NSColor(named: "GraphiteBorder")?.cgColor
                alphaValue = 1
            case .none:
                alphaValue = 0
            }
        }
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        _updateControlColourScheme()
    }
}

extension SNWindowControl {
    enum ControlColourScheme: Int {
        case colourful = 0
        case graphite = 1
        case none = 2
    }
    
    enum ControlType: String {
        case close = "Close"
        case minimise = "Minimise"
        case restore = "Restore"
    }
}
