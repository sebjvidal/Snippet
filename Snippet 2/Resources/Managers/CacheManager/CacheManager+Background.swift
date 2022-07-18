//
//  CacheManager+Background.swift
//  Snippet
//
//  Created by Seb Vidal on 02/07/2022.
//

import Cocoa

extension CacheManager {
    // MARK: Background
    /// Cached background
    var background: Int {
        return _loadBackground()
    }
    
    /// Load the cached background
    private func _loadBackground() -> Int {
        return 0
    }
    
    /// Set the cached background
    func setBackground(to background: SNBackgroundType) {
        switch background {
        case .none:
            _setBackgroundNone()
        case .solidColour:
            _setBackgroundColor()
        case .gradient(type: let type):
            _setBackgroundGradient(to: type)
        case .image(let type):
            _setBackgroundImage(to: type)
        }
    }
    
    private func _setBackgroundNone() {
        
    }
    
    private func _setBackgroundColor() {
        
    }
    
    private func _setBackgroundGradient(to type: SNBackgroundGradientType) {
        
    }
    
    private func _setBackgroundImage(to type: SNBackgroundImageType) {

    }
}
