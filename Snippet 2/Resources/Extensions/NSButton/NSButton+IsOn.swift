//
//  NSButton+IsOn.swift
//  Snippet
//
//  Created by Seb Vidal on 21/07/2022.
//

import Cocoa

extension NSButton {
    var isOn: Bool {
        set {
            state = newValue ? .on : .off
        }
        
        get {
            return state == .on ? true : false
        }
    }
}
