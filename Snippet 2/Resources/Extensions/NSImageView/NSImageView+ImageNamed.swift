//
//  NSImageView+ImageNamed.swift
//  Snippet
//
//  Created by Seb Vidal on 12/07/2022.
//

import Cocoa

extension NSImageView {
    convenience init(imageNamed name: String) {
        self.init(image: NSImage(named: name) ?? NSImage())
    }
}
