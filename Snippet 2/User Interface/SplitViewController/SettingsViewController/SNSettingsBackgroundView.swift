//
//  SNSettingsBackgroundView.swift
//  Snippet
//
//  Created by Seb Vidal on 02/07/2022.
//

import Cocoa

class SNSettingsBackgroundView: NSView {
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        layer?.backgroundColor = NSColor(named: "SecondaryBackground")?.cgColor
    }
}
