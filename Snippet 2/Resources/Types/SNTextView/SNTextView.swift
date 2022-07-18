//
//  SNTextView.swift
//  Snippet
//
//  Created by Seb Vidal on 17/07/2022.
//

import Cocoa

class SNTextView: NSTextView {
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        _setupTextView()
    }

    private func _setupTextView() {
        isRichText = false
        drawsBackground = false
        isVerticallyResizable = true
        isHorizontallyResizable = true
        font = NSFont(name: "SFMono-Regular", size: 15)

        textContainer?.widthTracksTextView = false
        textContainer?.heightTracksTextView = false
        textContainer?.size.width = .greatestFiniteMagnitude
        maxSize = NSSize(width: 999999999, height: 999999999)
    }

    override func layout() {
        super.layout()
        superview?.layout()
    }
}
