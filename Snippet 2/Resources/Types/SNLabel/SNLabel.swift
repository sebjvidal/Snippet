//
//  SNLabel.swift
//  Snippet
//
//  Created by Seb Vidal on 04/07/2022.
//

import Cocoa

class SNLabel: NSTextField {
    // MARK: Text
    var text: String {
        get {
            return stringValue
        }
        
        set {
            stringValue = newValue
            invalidateIntrinsicContentSize()
            superview?.layout()
        }
    }
    
    // MARK: Init
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        font = .systemFont(ofSize: 13)
        textColor = .labelColor
        drawsBackground = false
        isBordered = false
        isEditable = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
