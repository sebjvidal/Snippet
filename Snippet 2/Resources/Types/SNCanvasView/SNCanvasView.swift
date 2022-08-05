//
//  SNCanvasView.swift
//  Snippet
//
//  Created by Seb Vidal on 17/07/2022.
//

import Cocoa

class SNCanvasView: NSView {
    weak var parent: NSViewController?
    
    private var _transparentView: NSView!
    private var _backgroundView: SNImageView!

    private var _windowView: SNWindowView!
    
    private var _closeControl: SNWindowControl!
    private var _minimiseControl: SNWindowControl!
    private var _restoreControl: SNWindowControl!
    
    private var _titleLabel: SNLabel!
    private var _iconImageView: NSImageView!
    
    private var _textView: SNTextView!
    
    private var _watermarkView: SNWatermarkView!
    
    // MARK: init(frame:)
    override init(frame: NSRect) {
        super.init(frame: frame)
        _setupView()
        _setupTransparentView()
        _setupBackgroundView()
        _setupWindowView()
        _setupControlsButton()
        _setupTitleLabel()
        _setupIconImageView()
        _setupTextView()
        _setupWatermarkView()
    }
    
    // MARK: init?(coder:)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _setupView() {
        if let name = CacheManager.shared.appearance {
            appearance = NSAppearance(named: name)
        }
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
        _backgroundView.wantsLayer = true
        _backgroundView.autoresizingMask = [.width, .height]
        
        let background = CacheManager.shared.background
        background.applyBackground(to: _backgroundView)
        
        addSubview(_backgroundView)
    }
    
    private func _setupWindowView() {
        _windowView = SNWindowView()
        _windowView.opacity = CacheManager.shared.opacity
        
        addSubview(_windowView)
    }
    
    private func _setupControlsButton() {
        _closeControl = SNWindowControl()
        _closeControl.controlType = .close
        _closeControl.appearance = NSAppearance(named: .aqua)
        _closeControl.colourScheme = CacheManager.shared.controlStyle
        
        addSubview(_closeControl)
        
        _minimiseControl = SNWindowControl()
        _minimiseControl.controlType = .minimise
        _minimiseControl.colourScheme = CacheManager.shared.controlStyle
        
        addSubview(_minimiseControl)
        
        _restoreControl = SNWindowControl()
        _restoreControl.controlType = .restore
        _restoreControl.colourScheme = CacheManager.shared.controlStyle
        
        addSubview(_restoreControl)
    }
    
    private func _setupTitleLabel() {
        _titleLabel = SNLabel()
        _titleLabel.textColor = .secondaryLabelColor
        _titleLabel.text = CacheManager.shared.title
        _titleLabel.lineBreakMode = .byTruncatingTail
        
        addSubview(_titleLabel)
    }
    
    private func _setupIconImageView() {
        _iconImageView = SNImageView()
        _iconImageView.image = NSImage(named: "TypeScriptIcon")
        _iconImageView.isHidden = !CacheManager.shared.showIcon
        
        addSubview(_iconImageView)
    }
    
    private func _setupTextView() {
        _textView = SNTextView()
        _textView.string = CacheManager.shared.editorText
        _textView.textDidChange()

        addSubview(_textView)
    }
    
    private func _setupWatermarkView() {
        _watermarkView = SNWatermarkView()
        _watermarkView.title = "Made with Snippet"
        _watermarkView.subtitle = "https://sebvidal.com/snippet"
        _watermarkView.image = NSImage(named: "SnippetIconSmall")
        
        addSubview(_watermarkView)
    }
    
    // MARK: layout()
    override func layout() {
        super.layout()
        _layoutSelf()
        _layoutWindowView()
        _layoutWindowControls()
        _layoutTitleLabel()
        _layoutIconImageView()
        _layoutTextView()
        _layoutWatermarkView()
    }
    
    private func _layoutSelf() {
        switch CacheManager.shared.aspectRatio.name {
        case .fill:
            _fillLayout()
        case .fit:
            _fitLayout()
        case .custom:
            return
        default:
            _aspectRatioLayout()
        }
        
        parent?.viewDidLayout()
    }
    
    @objc private func _fillLayout() {
        guard let parent = parent as? SNCanvasViewController else {
            return
        }

        let hPadding = CGFloat(CacheManager.shared.horizontalPadding * 4)
        let vPadding = CGFloat(CacheManager.shared.verticalPadding * 4)
        
        let textViewWidth = _textView.frame.width < 268 ? 268 : _textView.frame.width
        let textViewHeight = _textView.frame.height
        
        let windowViewWidth = textViewWidth + 16 + 16 + hPadding
        let windowViewHeight = textViewHeight + 50 + 16 + vPadding
        
        let minWidth = parent.scrollView.frame.width
        let minHeight = parent.scrollView.frame.height
        
        let width = windowViewWidth < minWidth ? minWidth : windowViewWidth
        let height = windowViewHeight < minHeight ? minHeight : windowViewHeight
        _intrinsicContentSize = NSSize(width: width, height: height)
    }
    
    private func _fitLayout() {
        let hPadding = CGFloat(CacheManager.shared.horizontalPadding * 4)
        let vPadding = CGFloat(CacheManager.shared.verticalPadding * 4)
        
        let textViewWidth = _textView.frame.width < 268 ? 268 : _textView.frame.width
        let textViewHeight = _textView.frame.height
        
        let width = textViewWidth + 16 + 16 + hPadding
        let height = textViewHeight + 50 + 16 + vPadding
        _intrinsicContentSize = NSSize(width: width, height: height)
    }
    
    private func _aspectRatioLayout() {
        let size = CacheManager.shared.aspectRatio
        let aspectRatio = size.height / size.width
        
        if aspectRatio.isNaN {
            return
        }
        
        let hPadding = CGFloat(CacheManager.shared.horizontalPadding * 4)
        let vPadding = CGFloat(CacheManager.shared.verticalPadding * 4)
        
        let textViewWidth = _textView.frame.width < 268 ? 268 : _textView.frame.width
        let textViewHeight = _textView.frame.height
        
        let windowViewWidth = textViewWidth + 16 + 16 + hPadding
        let windowViewHeight = textViewHeight + 50 + 16 + vPadding
        
        if windowViewWidth / size.width > windowViewHeight / size.height {
            let width = windowViewWidth
            let height = width * aspectRatio
            _intrinsicContentSize = NSSize(width: width, height: height)
        } else {
            let height = windowViewHeight
            let width = height / aspectRatio
            _intrinsicContentSize = NSSize(width: width, height: height)
        }
    }
    
    private func _layoutWindowView() {
        let textViewWidth = _textView.frame.width + 16 + 16
        let textViewHeight = _textView.frame.height + 50 + 16
        
        let width = textViewWidth < 300 ? 300 : textViewWidth
        let height = textViewHeight < 85 ? 85 : textViewHeight
        
        let x = (frame.width / 2) - (width / 2)
        let y = (frame.height / 2) - (height / 2)
        
        _windowView.frame = CGRect(x: x, y: y, width: width, height: height)
    }
    
    private func _layoutWindowControls() {
        let x = _windowView.frame.minX + 20
        let y = _windowView.frame.maxY - 32
        
        _closeControl.frame = CGRect(x: x, y: y, width: 12, height: 12)
        _minimiseControl.frame = CGRect(x: x + 20, y: y, width: 12, height: 12)
        _restoreControl.frame = CGRect(x: x + 40, y: y, width: 12, height: 12)
    }
    
    private func _layoutTitleLabel() {
        let width = _titleLabel.attributedStringValue.size().width
        let height = _titleLabel.attributedStringValue.size().height
        
        var x = _windowView.frame.midX - (width / 2)
        let y = _windowView.frame.maxY - height - 17
        
        if CacheManager.shared.showIcon {
            x += 14
        }
        
        _titleLabel.frame = CGRect(x: x, y: y, width: width + 10, height: height)
    }
    
    private func _layoutIconImageView() {
        let x = _titleLabel.frame.minX - 19 - 6
        let y = _titleLabel.frame.minY - 1
        
        _iconImageView.frame = CGRect(x: x, y: y, width: 19, height: 19)
    }
    
    private func _layoutTextView() {
        let width = _textView.frame.width
        let height = _textView.frame.height
        
        let x = _windowView.frame.minX + 16
        let y = _windowView.frame.maxY  - height - 50
        
        _textView.frame = CGRect(x: x, y: y, width: width < 268 ? 268 : width, height: height)
    }
    
    private func _layoutWatermarkView() {
//        _watermarkView.frame = 
    }
    
    // MARK: draw(_:)
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        let image = NSImage(named: "Checkers")!
        let colour = NSColor(patternImage: image)
        _transparentView.layer?.backgroundColor = colour.cgColor
    }
    
    // MARK: intrinsicContentSize
    private var _intrinsicContentSize: NSSize = NSSize(width: 700, height: 500)
    override var intrinsicContentSize: NSSize {
        return _intrinsicContentSize
    }
    
    // MARK: setTitle(to:)
    func setTitle(to string: String) {
        _titleLabel.text = string
        _titleLabel.invalidateIntrinsicContentSize()
    }
    
    // MARK: setShowIcon(to:)
    func setShowIcon(to bool: Bool) {
        _iconImageView.isHidden = !bool
        layout()
    }
    
    // MARK: setControlStyle(to:)
    func setControlStyle(to colourScheme: SNWindowControl.ControlColourScheme) {
        _closeControl.colourScheme = colourScheme
        _minimiseControl.colourScheme = colourScheme
        _restoreControl.colourScheme = colourScheme
    }
    
    // MARK: setAppearance(to:)
    func setAppearance(to name: NSAppearance.Name?) {
        if let name = name {
            appearance = NSAppearance(named: name)
        } else {
            appearance = nil
        }
    }
    
    // MARK: setOpacity(to:)
    func setOpacity(to double: Double) {
        _windowView.opacity = double
    }
    
    // MARK: updatePadding()
    func updatePadding() {
        layout()
    }
    
    
    
    
    
    
    
    
    // MARK: toggleBackground(on:)
    func toggleBackground(on: Bool) {
        _backgroundView.alphaValue = on ? 1 : 0
    }
    
    // MARK: setBackground(to:)
    func setBackground(to background: SNBackground) {
        _backgroundView.dynamicImage = nil
        _backgroundView.backgroundColour = nil
        _backgroundView.gradientLayer.colors = nil
        
        background.applyBackground(to: _backgroundView)
    }
    
    // MARK: updateAspectRatio()
    func updateAspectRatio() {
        layout()
    }
}
