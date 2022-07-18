//
//  NSFont+SystemFontOfSizeWeightDesign.swift
//  Snippet
//
//  Created by Seb Vidal on 06/07/2022.
//

import Cocoa

extension NSFont {
    static func systemFont(ofSize size: CGFloat, weight: Weight, design: NSFontDescriptor.SystemDesign) -> NSFont {
        let font = NSFont.systemFont(ofSize: size, weight: weight)
        let descriptor = font.fontDescriptor.withDesign(design)!
        
        return NSFont(descriptor: descriptor, size: size)!
    }
}
