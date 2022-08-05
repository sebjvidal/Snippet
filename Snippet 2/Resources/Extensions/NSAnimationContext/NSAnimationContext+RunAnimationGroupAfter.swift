//
//  NSAnimationContext+RunAnimationGroupAfter.swift
//  Snippet
//
//  Created by Seb Vidal on 15/07/2022.
//

import Cocoa

extension NSAnimationContext {
    static func runAnimationGroupAfter(deadline: DispatchTime, changes: @escaping (NSAnimationContext) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            changes(NSAnimationContext())
        }
    }
}
