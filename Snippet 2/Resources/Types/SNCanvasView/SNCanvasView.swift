//
//  SNCanvasView.swift
//  Snippet
//
//  Created by Seb Vidal on 17/07/2022.
//

import Cocoa

class SNCanvasView: NSView {
    private var _transparentView: NSView!
    private var _backgroundView: SNImageView!
    
    private var _windowContainerView: NSView!
    private var _windowView: NSVisualEffectView!
    
    private var _closeControl: SNWindowControl!
    private var _minimiseControl: SNWindowControl!
    private var _restoreControl: SNWindowControl!
    
    private var _iconImageView: NSImageView!
    private var _titleLabel: SNLabel!
    
    private var _textView: SNTextView!
    
    // MARK: Init
    override init(frame: NSRect) {
        super.init(frame: frame)
        _setupTransparentView()
        _setupBackgroundView()
        _setupWindowContainerView()
        _setupWindowView()
        _setupControlsButton()
        _setupTitleLabel()
        _setupTextView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _setupTransparentView() {
        let image = NSImage(named: "Checkers")!
        let colour = NSColor(patternImage: image)
        
        _transparentView = NSView()
        _transparentView.wantsLayer = true
        _transparentView.layer?.backgroundColor = colour.cgColor
        _transparentView.autoresizingMask = [.width, .height]
        
        addSubview(_transparentView)
    }
    
    private func _setupBackgroundView() {
        _backgroundView = SNImageView()
        _backgroundView.autoresizingMask = [.width, .height]
        
        addSubview(_backgroundView)
    }
    
    private func _setupWindowContainerView() {
        _windowContainerView = NSView()
        _windowContainerView.wantsLayer = true
        _windowContainerView.shadow = NSShadow()
        _windowContainerView.layer?.shadowRadius = 0.5
        _windowContainerView.layer?.shadowOpacity = 0.7
        _windowContainerView.layer?.shadowColor = NSColor.black.cgColor
        
        addSubview(_windowContainerView)
    }
    
    private func _setupWindowView() {
        _windowView = NSVisualEffectView()
        _windowView.state = .active
        _windowView.wantsLayer = true
        _windowView.material = .sidebar
        _windowView.layer?.cornerRadius = 11.5
        _windowView.layer?.masksToBounds = true
        _windowView.blendingMode = .withinWindow
        _windowView.layer?.cornerCurve = .continuous
        
        _windowContainerView.addSubview(_windowView)
    }
    
    private func _setupControlsButton() {
        _closeControl = SNWindowControl()
        _closeControl.controlType = .close
        
        addSubview(_closeControl)
        
        _minimiseControl = SNWindowControl()
        _minimiseControl.controlType = .minimise
        
        addSubview(_minimiseControl)
        
        _restoreControl = SNWindowControl()
        _restoreControl.controlType = .restore
        
        addSubview(_restoreControl)
    }
    
    private func _setupTitleLabel() {
        _titleLabel = SNLabel()
        _titleLabel.lineBreakMode = .byClipping
        _titleLabel.font = .systemFont(ofSize: 13)
        _titleLabel.textColor = .secondaryLabelColor
        _titleLabel.text = "Untitled"
        
        addSubview(_titleLabel)
    }
    
    private func _setupTextView() {
        _textView = SNTextView()
        _textView.string = "Test 123"
        _textView.frame = CGRect(x: 100, y: 100, width: 150, height: 150)

        addSubview(_textView)
    }
    
    // MARK: Layout
    override func layout() {
        super.layout()
        _layoutWindowContainerView()
        _layoutWindowView()
        _layoutWindowControls()
        _layoutTitleLabel()
        _layoutTextView()
    }
    
    private func _layoutWindowContainerView() {
        let textViewWidth = _textView.frame.width + 16 + 16
        let textViewHeight = _textView.frame.height + 50 + 16
        
        let width = textViewWidth < 300 ? 300 : textViewWidth
        let height = textViewHeight < 85 ? 85 : textViewHeight
        
        let x = (frame.width / 2) - (width / 2)
        let y = (frame.height / 2) - (height / 2)
        
        _windowContainerView.frame = CGRect(x: x, y: y, width: width, height: height)
    }
    
    private func _layoutWindowView() {
        let width = _windowContainerView.frame.width
        let height = _windowContainerView.frame.height
        _windowView.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }
    
    private func _layoutWindowControls() {
        let x = _windowContainerView.frame.minX + 20
        let y = _windowContainerView.frame.maxY - 32
        
        _closeControl.frame = CGRect(x: x, y: y, width: 12, height: 12)
        _minimiseControl.frame = CGRect(x: x + 20, y: y, width: 12, height: 12)
        _restoreControl.frame = CGRect(x: x + 40, y: y, width: 12, height: 12)
    }
    
    private func _layoutTitleLabel() {
        let width = _titleLabel.intrinsicContentSize.width + 2
        let height = _titleLabel.intrinsicContentSize.height
        
        let x = _windowContainerView.frame.midX - (width / 2)
        let y = _windowContainerView.frame.maxY - height - 17
        
        _titleLabel.frame = CGRect(x: x, y: y, width: width, height: height)
    }
    
    private func _layoutTextView() {
        let width = _textView.frame.width
        let height = _textView.frame.height
        
        let x = _windowContainerView.frame.minX + 16
        let y = _windowContainerView.frame.maxY  - height - 50
        
        _textView.frame = CGRect(x: x, y: y, width: width, height: height)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        let image = NSImage(named: "Checkers")!
        let colour = NSColor(patternImage: image)
        _transparentView.layer?.backgroundColor = colour.cgColor
    }
    
    override var intrinsicContentSize: NSSize {
        return NSSize(width: 500, height: 500)
    }
}
