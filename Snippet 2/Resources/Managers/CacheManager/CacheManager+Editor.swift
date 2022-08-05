//
//  CacheManager+Editor.swift
//  Snippet
//
//  Created by Seb Vidal on 22/07/2022.
//

import Cocoa
import Splash

extension CacheManager {
    // MARK: Language
    var language: String {
        _loadLanguage()
    }
    
    private func _loadLanguage() -> String {
        return defaults.string(forKey: "language") ?? "Swift"
    }
    
    func setLanguage(to string: String) {
        defaults.set(string, forKey: "language")
    }
    
    // MARK: Languages
    var languages: [String: Grammar.Type] {
        return [
            "JavaScript": JavaScriptGrammar.self,
            "Python": PythonGrammar.self,
            "Swift": SwiftGrammar.self,
            "TypeScript": TypeScriptGrammar.self
        ]
    }
    
    // MARK: Theme
    var theme: Theme {
        _loadTheme()
    }
    
    private func _loadTheme() -> Theme {
        let nsFont = NSFont(name: _loadFont(), size: _loadFontSize())
        let font = Font(nsFont: nsFont ?? .systemFont(ofSize: _loadFontSize()))
        let name = defaults.string(forKey: "theme") ?? "Xcode"
        let theme = _loadThemes().first(where: { $0.name == name }) ?? .xcodeDefault(withFont: font)
    
        return theme
    }
    
    func setTheme(to name: String) {
        defaults.set(name, forKey: "theme")
    }
    
    // MARK: Themes
    var themes: [Theme] {
        _loadThemes()
    }
    
    private func _loadThemes() -> [Theme] {
        let json = _loadThemesJSON()
        let nsFont = NSFont(name: _loadFont(), size: _loadFontSize())
        let font = Font(nsFont: nsFont ?? .systemFont(ofSize: _loadFontSize()))
        var themes: [Theme] = []
        
        for obj in json {
            let theme = Theme.from(json, named: obj.key, withFont: font)
            themes.append(theme)
        }
        
        for _default in Theme.defaults {
            if let theme = Theme.default(forKey: _default, withFont: font) {
                themes.append(theme)
            }
        }
        
        return themes
    }
    
    private func _loadThemesJSON() -> [String: Any] {
        if let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let url = path.appendingPathComponent("themes.txt")
            do {
                if try url.checkResourceIsReachable() {
                    if let json = try JSONSerialization.jsonObject(with: Data(contentsOf: url)) as? [String: Any] {
                        return json
                    }
                }
            } catch {}
        }
        
        return [:]
    }
    
    // MARK: Font
    var font: String {
        _loadFont()
    }
    
    private func _loadFont() -> String {
        return defaults.string(forKey: "font") ?? "SF Mono"
    }
    
    func setFont(to name: String) {
        defaults.set(name, forKey: "font")
    }
    
    // MARK: Fonts
    var fonts: [String: String] {
        _loadFonts()
    }
    
    private func _loadFonts() -> [String: String] {
        let fonts = [
            "Andale Mono": "AndaleMono",
            "Anonymous Pro": "AnonymousPro",
            "Courier New": "CourierNewPSMT",
            "Fira Code": "FiraCode-Regular",
            "JetBrains Mono": "JetBrainsMono-Regular",
            "Menlo": "Menlo-Regular",
            "PT Mono": "PTMono-Regular",
            "Roboto Mono": "RobotoMono-Regular",
            "SF Mono": "SFMono-Regular",
            "Source Code Pro": "SourceCodePro-Regular",
            "Ubuntu Mono": "UbuntuMono-Regular"
        ]
        
        return fonts
    }
    
    // MARK: FontSize
    var fontSize: CGFloat {
        _loadFontSize()
    }
    
    private func _loadFontSize() -> CGFloat {
        if defaults.keyExists(key: "fontSize") {
            return defaults.float(forKey: "fontSize").cgFloat
        }
        
        return 15.0
    }
    
    func setFontSize(to cgFloat: CGFloat) {
        defaults.set(cgFloat, forKey: "fontSize")
    }
    
    // MARK: Bold
    var bold: Bool {
        _loadBold()
    }
    
    private func _loadBold() -> Bool {
        return defaults.bool(forKey: "bold")
    }
    
    func setBold(to bool: Bool) {
        defaults.set(bool, forKey: "bold")
    }
    
    // MARK: Italic
    var italic: Bool {
        _loadItalic()
    }
    
    private func _loadItalic() -> Bool {
        return defaults.bool(forKey: "italic")
    }
    
    func setItalic(to bool: Bool) {
        defaults.set(bool, forKey: "italic")
    }
    
    // MARK: Underline
    var underline: Bool {
        _loadUnderline()
    }
    
    private func _loadUnderline() -> Bool {
        return defaults.bool(forKey: "underline")
    }
    
    func setUnderline(to bool: Bool) {
        defaults.set(bool, forKey: "underline")
    }
    
    // MARK: Strikethrough
    var strikethrough: Bool {
        _loadStrikethrough()
    }
    
    private func _loadStrikethrough() -> Bool {
        return defaults.bool(forKey: "strikethrough")
    }
    
    func setStrikethrough(to bool: Bool) {
        defaults.set(bool, forKey: "strikethrough")
    }
    
    // MARK: EnableLineNumbers
    var enableLineNumbers: Bool {
        _loadEnableLineNumbers()
    }
    
    private func _loadEnableLineNumbers() -> Bool {
        if defaults.keyExists(key: "showLineNumbers") {
            return defaults.bool(forKey: "showLineNumbers")
        }
        
        return true
    }
    
    func setEnableLineNumbers(to bool: Bool) {
        defaults.set(bool, forKey: "showLineNumbers")
    }
    
    // MARK: LineNumberStart
    var lineNumberStart: Int {
        _loadLineNumberStart()
    }
    
    private func _loadLineNumberStart() -> Int {
        if defaults.keyExists(key: "lineStart") {
            return defaults.integer(forKey: "lineStart")
        }
        
        return 1
    }
    
    func setLineNumberStart(to int: Int) {
        defaults.set(int, forKey: "lineStart")
    }
}
