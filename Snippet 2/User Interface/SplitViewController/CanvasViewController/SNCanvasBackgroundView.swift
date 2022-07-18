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
        layer?.backgroundColor = NSColor(named: "CanvasBackground")?.cgColor
        layer?.cornerCurve = .continuous
        layer?.cornerRadius = 4
        layer?.borderColor = NSColor(named: "CanvasBorder")?.cgColor
        layer?.borderWidth = 1
        layer?.masksToBounds = true
    }
    
    // MARK: ViewDidChangeEffectiveAppearance
    override func viewDidChangeEffectiveAppearance() {
        super.viewDidChangeEffectiveAppearance()
        layer?.backgroundColor = NSColor(named: "CanvasBackground")?.cgColor
    }
}
