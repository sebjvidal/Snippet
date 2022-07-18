//
//  NSImage+SystemSymbolName.swift
//  Snippet
//
//  Created by Seb Vidal on 27/06/2022.
//

import Cocoa

extension NSImage {
    convenience init?(systemSymbolName: String) {
        self.init(systemSymbolName: systemSymbolName, accessibilityDescription: nil)
    }
}
