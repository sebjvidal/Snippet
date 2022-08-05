//
//  SNCanvasScrollView.swift
//  Snippet
//
//  Created by Seb Vidal on 31/07/2022.
//

import Cocoa

class SNCanvasScrollView: NSScrollView {
    // MARK: init()
    init() {
        super.init(frame: .zero)
        contentView = SNClipView()
        contentView.wantsLayer = true
        contentView.layer?.borderWidth = 1
        contentView.layer?.cornerRadius = 4
        contentView.layer?.cornerCurve = .continuous
        contentView.layer?.borderColor = NSColor(named: "CanvasBorder")?.cgColor
    }
    
    // MARK: init?(coder)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: viewDidChangeEffectiveAppearance()
    override func viewDidChangeEffectiveAppearance() {
        super.viewDidChangeEffectiveAppearance()
        NSAppearance.current(in: self).performAsCurrentDrawingAppearance {
            contentView.layer?.borderColor = NSColor(named: "CanvasBorder")?.cgColor
        }
    }
}
