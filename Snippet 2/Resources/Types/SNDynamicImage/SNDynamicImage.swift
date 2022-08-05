//
//  SNDynamicImage.swift
//  Snippet
//
//  Created by Seb Vidal on 25/07/2022.
//

import Cocoa

class SNDynamicImage: SNBackground {
    private(set) var light: NSImage?
    private(set) var dark: NSImage?
    
    init(light: NSImage?, dark: NSImage?) {
        self.light = light
        self.dark = dark
    }
    
    convenience init() {
        self.init(light: nil, dark: nil)
    }
    
    func applyBackground(to view: SNImageView) {
        view.dynamicImage = self
    }
}
