//
//  NSFont+SystemFontOfSizeDesign.swift
//  Snippet
//
//  Created by Seb Vidal on 08/07/2022.
//

import Cocoa

extension NSFont {
    static func systemFont(ofSize size: CGFloat, design: NSFontDescriptor.SystemDesign) -> NSFont {
        return .systemFont(ofSize: size, weight: .regular, design: design)
    }
}
