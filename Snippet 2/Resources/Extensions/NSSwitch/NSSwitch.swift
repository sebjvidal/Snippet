//
//  NSSwitch.swift
//  Snippet
//
//  Created by Seb Vidal on 22/07/2022.
//

import Cocoa

extension NSSwitch {
    var isOn: Bool {
        set {
            state = newValue ? .on : .off
        }
        
        get {
            return state == .on ? true : false
        }
    }
}
