//
//  NSAppearance+IsLight.swift
//  Snippet
//
//  Created by Seb Vidal on 17/07/2022.
//

import Cocoa

extension NSAppearance {
    var isLight: Bool {
        return bestMatch(from: [.aqua, .darkAqua]) == .aqua
    }
}
