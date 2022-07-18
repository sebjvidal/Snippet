//
//  NSAppearance+CurrentIn.swift
//  Snippet
//
//  Created by Seb Vidal on 07/07/2022.
//

import Cocoa

extension NSAppearance {
    static func current(in view: NSView) -> NSAppearance {
        return NSAppearance(named: view.effectiveAppearance.bestMatch(from: [.aqua, .darkAqua])!)!
    }
}
