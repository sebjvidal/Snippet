//
//  SNCanvasBackgroundView.swift
//  Snippet
//
//  Created by Seb Vidal on 28/06/2022.
//

import Cocoa

class SNCanvasBackgroundView: NSView {
    // MARK: Draw
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        _setupCanvasBackgroundView()
    }
    
    private func _setupCanvasBackgroundView() {
        wantsLayer = true
        layer?.cornerRadius = 4
        layer?.masksToBounds = true
        layer?.cornerCurve = .continuous
        layer?.backgroundColor = NSColor(named: "CanvasBackground")?.cgColor
    }
    
    // MARK: ViewDidChangeEffectiveAppearance
    override func viewDidChangeEffectiveAppearance() {
        super.viewDidChangeEffectiveAppearance()
        layer?.backgroundColor = NSColor(named: "CanvasBackground")?.cgColor
    }
}
