//
//  SNGradientGripDelegate.swift
//  Snippet
//
//  Created by Seb Vidal on 14/07/2022.
//

import Cocoa

protocol SNGradientGripDelegate {
    func colourWillChange(from colour: HSV)
    func colourDidChange(to colour: HSV)
}

extension SNGradientGripDelegate {
    func colourWillChange(from colour: HSV) {}
    func colourDidChange(to colour: HSV) {}
}
