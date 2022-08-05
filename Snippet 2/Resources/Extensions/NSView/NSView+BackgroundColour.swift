//
//  NSView+BackgroundColour.swift
//  Snippet
//
//  Created by Seb Vidal on 19/07/2022.
//

import Cocoa

extension NSView {
    var backgroundColour: NSColor? {
        set {
            wantsLayer = true
            layer?.backgroundColor = newValue?.cgColor
        }
        
        get {
            if let layer = layer, let colour = layer.backgroundColor {
                return NSColor(cgColor: colour)
            }
            
            return nil
        }
    }
}
