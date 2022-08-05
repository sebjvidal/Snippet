//
//  CacheManager+Window.swift
//  Snippet
//
//  Created by Seb Vidal on 19/07/2022.
//

import Cocoa

extension CacheManager {
    // MARK: Title
    var title: String {
        _loadTitle()
    }
    
    private func _loadTitle() -> String {
        return defaults.string(forKey: "title") ?? "Untitled"
    }
    
    func setTitle(to string: String) {
        defaults.set(string, forKey: "title")
    }
    
    // MARK: ShowIcon
    var showIcon: Bool {
        _loadShowIcon()
    }
    
    private func _loadShowIcon() -> Bool {
        return defaults.bool(forKey: "showIcon")
    }
    
    func setShowIcon(to bool: Bool) {
        defaults.set(bool, forKey: "showIcon")
    }
    
    // MARK: ControlStyle
    var controlStyle: SNWindowControl.ControlColourScheme {
        _loadControlStyle()
    }
    
    private func _loadControlStyle() -> SNWindowControl.ControlColourScheme {
        return SNWindowControl.ControlColourScheme(
            rawValue: defaults.integer(forKey: "controls")
        ) ?? .colourful
    }
    
    func setControlStyle(to controlColourScheme: SNWindowControl.ControlColourScheme) {
        defaults.set(controlColourScheme.rawValue, forKey: "controls")
    }
    
    // MARK: Appearance
    var appearance: NSAppearance.Name? {
        _loadAppearance()
    }
    
    private func _loadAppearance() -> NSAppearance.Name? {
        if defaults.keyExists(key: "appearance") {
            return NSAppearance.Name(defaults.string(forKey: "appearance")!)
        }
        
        return nil
    }
    
    func setAppearance(to appearance: NSAppearance.Name?) {
        defaults.set(appearance?.rawValue, forKey: "appearance")
    }
    
    // MARK: Opacity
    var opacity: Double {
        _loadOpacity()
    }
    
    private func _loadOpacity() -> Double {
        if defaults.keyExists(key: "windowOpacity") {
            return defaults.double(forKey: "windowOpacity")
        }
        
        return 0.5
    }
    
    func setOpacity(to double: Double) {
        defaults.set(double, forKey: "windowOpacity")
    }
    
    // MARK: PaddingEnabled
    var paddingEnabled: Bool {
        _loadPaddingEnabled()
    }
    
    private func _loadPaddingEnabled() -> Bool {
        if defaults.keyExists(key: "paddingEnabled") {
            return defaults.bool(forKey: "paddingEnabled")
        }
        
        return true
    }
    
    func setPaddingEnabled(to bool: Bool) {
        defaults.set(bool, forKey: "paddingEnabled")
    }
    
    // MARK: HorizontalPadding
    var horizontalPadding: Int {
        _loadHorizontalPadding()
    }
    
    private func _loadHorizontalPadding() -> Int {
        if defaults.keyExists(key: "hPadding") {
            return defaults.integer(forKey: "hPadding")
        }
        
        return 64
    }
    
    func setHorizontalPadding(to int: Int) {
        defaults.set(int, forKey: "hPadding")
    }
    
    // MARK: VerticalPadding
    var verticalPadding: Int {
        _loadVerticalPadding()
    }
    
    private func _loadVerticalPadding() -> Int {
        if defaults.keyExists(key: "vPadding") {
            return defaults.integer(forKey: "vPadding")
        }
        
        return 64
    }
    
    func setVerticalPadding(to int: Int) {
        defaults.set(int, forKey: "vPadding")
    }
    
    // MARK: MatchedPadding
    var matchedPadding: Bool {
        _loadMatchedPadding()
    }
    
    private func _loadMatchedPadding() -> Bool {
        if defaults.keyExists(key: "matchedPadding") {
            return defaults.bool(forKey: "matchedPadding")
        }
        
        return true
    }
    
    func setMatchedPadding(to bool: Bool) {
        defaults.set(bool, forKey: "matchedPadding")
    }
}
