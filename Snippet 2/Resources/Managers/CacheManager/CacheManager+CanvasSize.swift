//
//  CacheManager+CanvasSize.swift
//  Snippet
//
//  Created by Seb Vidal on 31/07/2022.
//

import Cocoa

extension CacheManager {
    // MARK: Aspect Ratio
    var aspectRatio: SNAspectRatio {
        _loadAspectRatio()
    }
    
    private func _loadAspectRatio() -> SNAspectRatio {
        if let aspectRatio = defaults.aspectRatio(forKey: "aspectRatio") {
            return aspectRatio
        }
        
        return .presets[0]
    }
    
    func setAspectRatio(to aspectRatio: SNAspectRatio) {
        defaults.set(aspectRatio, forKey: "aspectRatio")
    }
    
    // MARK: Custom Aspect Ratio
    var customAspectRatio: SNAspectRatio {
        _loadCustomAspectRatio()
    }
    
    private func _loadCustomAspectRatio() -> SNAspectRatio {
        if let customAspectRatio = defaults.aspectRatio(forKey: "customAspectRatio") {
            return customAspectRatio
        }
        
        return SNAspectRatio(name: .custom, width: 1920, height: 1080)
    }
}
