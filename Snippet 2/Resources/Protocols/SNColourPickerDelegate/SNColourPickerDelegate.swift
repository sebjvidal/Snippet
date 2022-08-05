//
//  SNColourPickerDelegate.swift
//  Snippet
//
//  Created by Seb Vidal on 05/08/2022.
//

import Cocoa

protocol SNColourPickerDelegate: AnyObject {
    func colourWillChange(toHue hue: Float, saturation: Float, vibrancy: Float, forFirstTime firstTime: Bool)
    func colourWillChange(toHue hue: Float, saturation: Float, vibrancy: Float)
    func colourDidChange(toHue hue: Float, saturation: Float, vibrancy: Float)
}

extension SNColourPickerDelegate {
    func colourWillChange(toHue hue: Float, saturation: Float, vibrancy: Float, forFirstTime firstTime: Bool) {
        return
    }
    
    func colourWillChange(toHue hue: Float, saturation: Float, vibrancy: Float) {
        return
    }
    
    func colourDidChange(toHue hue: Float, saturation: Float, vibrancy: Float) {
        return
    }
}
