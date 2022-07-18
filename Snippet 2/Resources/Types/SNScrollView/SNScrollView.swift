//
//  SNScrollView.swift
//  Snippet
//
//  Created by Seb Vidal on 04/07/2022.
//

import Cocoa

class SNScrollView: NSScrollView {
    // MARK: Init
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        drawsBackground = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: IsFlipped
    override var isFlipped: Bool {
        return true
    }
    
    override func layout() {
        super.layout()
        hasVerticalScroller = true
    }
}
