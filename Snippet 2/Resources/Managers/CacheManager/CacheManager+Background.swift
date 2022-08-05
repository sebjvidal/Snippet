//
//  CacheManager+Background.swift
//  Snippet
//
//  Created by Seb Vidal on 02/07/2022.
//

import Cocoa

extension CacheManager {
    // MARK: Background Enabled
    var backgroundEnabled: Bool {
        _loadBackgroundEnabled()
    }
    
    private func _loadBackgroundEnabled() -> Bool {
        if defaults.keyExists(key: "backgroundEnabled") {
            return defaults.bool(forKey: "backgroundEnabled")
        }
        
        return true
    }
    
    func setBackgroundEnabled(to bool: Bool) {
        defaults.set(bool, forKey: "backgroundEnabled")
    }
    
    // MARK: Background Type
    var backgroundType: SNBackgroundType {
        _loadBackgroundType()
    }

    private func _loadBackgroundType() -> SNBackgroundType {
        let string = defaults.string(forKey: "backgroundType") ?? "SNSolidColour"
        return SNBackgroundType(rawValue: string) ?? .solidColour
    }

    func setBackgroundType(to type: SNBackgroundType) {
        defaults.set(type.rawValue, forKey: "backgroundType")
    }
    
    // MARK: Background
    var background: SNBackground {
        _loadBackground()
    }
    
    private func _loadBackground() -> SNBackground {
        switch _loadBackgroundType() {
        case .solidColour:
            return _loadSolidColour()
        case .gradient:
            return _loadGradient()
        case .image:
            return _loadImage()
        }
    }
    
    func setBackground(to background: SNBackground) {
        if let solidColour = background as? SNSolidColour {
            setSolidColour(to: solidColour)
            setBackgroundType(to: .solidColour)
        } else if let gradient = background as? SNGradient {
            setGradient(to: gradient)
            setBackgroundType(to: .gradient)
        } else if let image = background as? SNImage {
            setImage(to: image)
            setBackgroundType(to: .image)
        }
    }
    
    // MARK: Solid Colour
    var solidColour: SNSolidColour {
        _loadSolidColour()
    }
    
    private func _loadSolidColour() -> SNSolidColour {
        if let solidColour = defaults.solidColour(forKey: "solidColour") {
            return solidColour
        }
        
        return .presets[0]
    }
    
    func setSolidColour(to solidColour: SNSolidColour) {
        defaults.set(solidColour, forKey: "solidColour")
    }
    
    // MARK: Gradient
    var gradient: SNGradient {
        _loadGradient()
    }
    
    private func _loadGradient() -> SNGradient {
        if let gradient = defaults.gradient(forKey: "gradient") {
            return gradient
        }
        
        return .presets[0]
    }
    
    func setGradient(to gradient: SNGradient) {
        defaults.set(gradient, forKey: "gradient")
    }
    
    // MARK: Image
    var image: SNImage {
        _loadImage()
    }
    
    private func _loadImage() -> SNImage {
        if let image = defaults.image(forKey: "image") {
            return image
        }
        
        return .presets[0]
    }
    
    func setImage(to image: SNImage) {
        defaults.set(image, forKey: "image")
    }
}
