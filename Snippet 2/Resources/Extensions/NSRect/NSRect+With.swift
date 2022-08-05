//
//  NSRect+With.swift
//  Snippet
//
//  Created by Seb Vidal on 05/08/2022.
//

import Cocoa

extension NSRect {
    func with(x newX: Double) -> NSRect {
        return NSRect(x: newX, y: minY, width: width, height: height)
    }
    
    func with(y newY: Double) -> NSRect {
        return NSRect(x: minX, y: newY, width: width, height: height)
    }
    
    func with(width newWidth: Double) -> NSRect {
        return NSRect(x: minX, y: minY, width: newWidth, height: height)
    }
    
    func with(height newHeight: Double) -> NSRect {
        return NSRect(x: minX, y: minY, width: width, height: newHeight)
    }
}
