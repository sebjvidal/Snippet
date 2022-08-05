//
//  SNTextView.swift
//  Snippet
//
//  Created by Seb Vidal on 17/07/2022.
//

import Cocoa
import Splash

class SNTextView: NSTextView, NSTextViewDelegate {
    // MARK: viewDidMoveToSuperview()
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        _setupTextView()
    }

    private func _setupTextView() {
        delegate = self
        allowsUndo = true
        isRichText = false
        drawsBackground = false
        isVerticallyResizable = true
        isHorizontallyResizable = true
        smartInsertDeleteEnabled = false
        isAutomaticDashSubstitutionEnabled = false
        isAutomaticQuoteSubstitutionEnabled = false
        isAutomaticSpellingCorrectionEnabled = false
        
        font = NSFont(name: "SFMono-Regular", size: 15)
        maxSize = NSSize(width: 999999999, height: 999999999)

        textContainer?.widthTracksTextView = false
        textContainer?.heightTracksTextView = false
        textContainer?.size.width = .greatestFiniteMagnitude
    }

    // MARK: layout()
    override func layout() {
        super.layout()
        superview?.layout()
    }
    
    // MARK: viewDidChangeEffectiveAppearance()
    override func viewDidChangeEffectiveAppearance() {
        textDidChange()
    }
    
    // MARK: textDidChange()
    func textDidChange() {
        textDidChange(Notification(name: NSText.didChangeNotification))
    }
    
    // MARK: insertTab(_:)
    override func insertTab(_ sender: Any?) {
        DispatchQueue.main.async { [unowned self] in
            if let range = selectedRanges.first?.rangeValue {
                textStorage?.beginEditing()
                insertText("    ", replacementRange: range)
                textStorage?.endEditing()
                
                let newRange = NSRange(location: range.location + 4, length: range.length)
                setSelectedRange(newRange)
            }
        }
    }
    
    // MARK: textDidChange(_:)
    func textDidChange(_ notification: Notification) {
        let name = CacheManager.shared.font
        let size = CacheManager.shared.fontSize
        let font = Font(nsFont: NSFont(name: name, size: size))
        
        let theme = Theme.xcodeDefault(withFont: font)
        let appearance = NSAppearance.current(in: self).name
        let format = AttributedStringOutputFormat(theme: theme, appearance: appearance)
        let highlighter = SyntaxHighlighter(format: format, grammar: SwiftGrammar())
        let attributedString = highlighter.highlight(string)
        
        CacheManager.shared.setEditorText(to: attributedString.string)
        
        if let range = selectedRanges.first?.rangeValue {
            textStorage?.setAttributedString(attributedString)
            setSelectedRange(range)
        }
    }
}
