//
//  SNSettingsToolbarSeparatorView.swift
//  Snippet
//
//  Created by Seb Vidal on 03/07/2022.
//

import Cocoa

class SNSettingsToolbarSeparatorView: NSView {
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        layer?.backgroundColor = NSColor(named: "ToolbarSeparator")?.cgColor
    }
}
