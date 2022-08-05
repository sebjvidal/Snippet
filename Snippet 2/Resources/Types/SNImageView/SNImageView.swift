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
    
    var gradientLayer = CAGradientLayer()
    
    override var intrinsicContentSize: NSSize {
        .zero
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        _setupGradientView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        if let image = image {
            self.image = image
        }
    }
    
    private func _setupGradientView() {
        let gradientView = NSView()
        gradientView.wantsLayer = true
        gradientView.autoresizingMask = [.width, .height]
        gradientView.layer?.addSublayer(gradientLayer)
        
        gradientLayer.autoresizingMask = [.layerWidthSizable, .layerHeightSizable]
        
        addSubview(gradientView)
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
        } else {
            self.layer?.contents = nil
        }
    }
}
