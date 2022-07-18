//
//  SNImageView.swift
//  Snippet
//
//  Created by Seb Vidal on 17/07/2022.
//

import Cocoa

class SNImageView: NSImageView {
    var dynamicImage: SNDynamicImage? {
        didSet {
            _updateImage()
        }
    }
    
    override var intrinsicContentSize: NSSize {
        .zero
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        if let image = image {
            self.image = image
        }
    }
    
    override func viewDidChangeEffectiveAppearance() {
        _updateImage()
    }
    
    private func _updateImage() {
        if let dynamicImage = dynamicImage {
            let isLight = NSAppearance.current(in: self).isLight
            let light = dynamicImage.light
            let dark = dynamicImage.dark
            
            self.layer = CALayer()
            self.layer?.contentsGravity = .resizeAspectFill
            self.layer?.contents = isLight ? light : dark
            self.wantsLayer = true
            
            super.image = isLight ? light : dark
        }
    }
}
