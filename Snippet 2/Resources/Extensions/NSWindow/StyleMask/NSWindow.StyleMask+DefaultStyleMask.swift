//
//  NSWindow.StyleMask+DefaultStyleMask.swift
//  Snippet
//
//  Created by Seb Vidal on 28/06/2022.
//

import Cocoa

extension NSWindow.StyleMask {
    static let defaultStyleMask: NSWindow.StyleMask = [
        .closable, .miniaturizable, .resizable, .unifiedTitleAndToolbar, .titled, .fullSizeContentView
    ]
}
