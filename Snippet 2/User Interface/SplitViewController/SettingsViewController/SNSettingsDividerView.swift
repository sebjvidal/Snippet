//
//  SNSettingsDividerView.swift
//  Snippet
//
//  Created by Seb Vidal on 04/07/2022.
//

import Cocoa

class SNSettingsDividerView: NSView {
    // MARK: Init
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        wantsLayer = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: IntrinsicContentSize
    override var intrinsicContentSize: NSSize {
        return NSSize(width: 30, height: 1)
    }
    
    // MARK: Draw
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        layer?.backgroundColor = NSColor(named: "SettingsDivider")?.cgColor
    }
}
