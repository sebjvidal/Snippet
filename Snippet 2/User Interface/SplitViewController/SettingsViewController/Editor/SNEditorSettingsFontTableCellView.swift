//
//  SNEditorSettingsFontTableCellView.swift
//  Snippet
//
//  Created by Seb Vidal on 07/07/2022.
//

import Cocoa

class SNEditorSettingsFontTableCellView: NSTableRowView, SNSettingsTableCellView {
    var height: CGFloat = 131
    
    private var _titleLabel: SNLabel!
    private var _fontComboBox: NSPopUpButton!
    private var _decreaseFontSizeButton: NSButton!
    private var _increaseFontSizeButton: NSButton!
    private var _fontSizeSlider: NSSlider!
    private var _fontStepper: NSStepper!
    private var _fontTextField: NSTextField!
    private var _styleSegmentedControl: NSSegmentedControl!
    private var _dividerView: SNSettingsDividerView!
    
    init() {
        super.init(frame: NSRect.zero)
        _setupTitleLabel()
        _setupFontComboBox()
        _setupFontStepper()
        _setupFontTextField()
        _setupFontSizeButtons()
        _setupFontSizeSlider()
        _setupStyleSegmentedControl()
        _setupDividerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _setupTitleLabel() {
        _titleLabel = SNLabel()
        _titleLabel.text = "Font:"
        _titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_titleLabel)
        
        NSLayoutConstraint.activate([
            _titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            _titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18)
        ])
    }
    
    private func _setupFontComboBox() {
        _fontComboBox = NSPopUpButton()
        _fontComboBox.addItems(withTitles: ["SF Mono"])
        _fontComboBox.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_fontComboBox)
        
        NSLayoutConstraint.activate([
            _fontComboBox.topAnchor.constraint(equalTo: _titleLabel.bottomAnchor, constant: 10),
            _fontComboBox.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            _fontComboBox.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18)
        ])
    }
    
    private func _setupFontStepper() {
        _fontStepper = NSStepper()
        _fontStepper.minValue = 15
        _fontStepper.maxValue = 30
        _fontStepper.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_fontStepper)
        
        NSLayoutConstraint.activate([
            _fontStepper.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            _fontStepper.topAnchor.constraint(equalTo: _fontComboBox.bottomAnchor, constant: 10)
        ])
    }
    
    private func _setupFontTextField() {
        _fontTextField = NSTextField()
        _fontTextField.stringValue = "15"
        _fontTextField.alignment = .center
        _fontTextField.bezelStyle = .roundedBezel
        _fontTextField.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_fontTextField)
        
        NSLayoutConstraint.activate([
            _fontTextField.trailingAnchor.constraint(equalTo: _fontStepper.leadingAnchor, constant: -2),
            _fontTextField.centerYAnchor.constraint(equalTo: _fontStepper.centerYAnchor),
            _fontTextField.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func _setupFontSizeButtons() {
        _decreaseFontSizeButton = NSButton()
        _decreaseFontSizeButton.title = "Aa"
        _decreaseFontSizeButton.isBordered = false
        _decreaseFontSizeButton.contentTintColor = .labelColor
        _decreaseFontSizeButton.font = .systemFont(ofSize: 11, design: .rounded)
        _decreaseFontSizeButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_decreaseFontSizeButton)
        
        NSLayoutConstraint.activate([
            _decreaseFontSizeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18)
        ])
        
        _increaseFontSizeButton = NSButton()
        _increaseFontSizeButton.title = "Aa"
        _increaseFontSizeButton.isBordered = false
        _increaseFontSizeButton.contentTintColor = .labelColor
        _increaseFontSizeButton.font = .systemFont(ofSize: 15, design: .rounded)
        _increaseFontSizeButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_increaseFontSizeButton)
        
        NSLayoutConstraint.activate([
            _increaseFontSizeButton.trailingAnchor.constraint(equalTo: _fontTextField.leadingAnchor, constant: -10)
        ])
    }
    
    private func _setupFontSizeSlider() {
        _fontSizeSlider = NSSlider()
        _fontSizeSlider.minValue = 10
        _fontSizeSlider.maxValue = 30
        _fontSizeSlider.intValue = 15
        _fontSizeSlider.numberOfTickMarks = 15
        _fontSizeSlider.allowsTickMarkValuesOnly = true
        _fontSizeSlider.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_fontSizeSlider)
        
        NSLayoutConstraint.activate([
            _fontSizeSlider.topAnchor.constraint(equalTo: _fontComboBox.bottomAnchor, constant: 10),
            _fontSizeSlider.leadingAnchor.constraint(equalTo: _decreaseFontSizeButton.trailingAnchor, constant: 10),
            _fontSizeSlider.trailingAnchor.constraint(equalTo: _increaseFontSizeButton.leadingAnchor, constant: -10),
            _fontSizeSlider.centerYAnchor.constraint(equalTo: _decreaseFontSizeButton.centerYAnchor),
            _fontSizeSlider.centerYAnchor.constraint(equalTo: _increaseFontSizeButton.centerYAnchor)
        ])
    }
    
    private func _setupStyleSegmentedControl() {
        _styleSegmentedControl = NSSegmentedControl()
        _styleSegmentedControl.trackingMode = .selectAny
        _styleSegmentedControl.segmentCount = 4
        _styleSegmentedControl.setImage(NSImage(systemSymbolName: "bold"), forSegment: 0)
        _styleSegmentedControl.setImage(NSImage(systemSymbolName: "italic"), forSegment: 1)
        _styleSegmentedControl.setImage(NSImage(systemSymbolName: "underline"), forSegment: 2)
        _styleSegmentedControl.setImage(NSImage(systemSymbolName: "strikethrough"), forSegment: 3)
        _styleSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_styleSegmentedControl)
        
        NSLayoutConstraint.activate([
            _styleSegmentedControl.topAnchor.constraint(equalTo: _fontTextField.bottomAnchor, constant: 10),
            _styleSegmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            _styleSegmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18)
        ])
    }
    
    private func _setupDividerView() {
        _dividerView = SNSettingsDividerView()
        _dividerView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(_dividerView)

        NSLayoutConstraint.activate([
            _dividerView.topAnchor.constraint(equalTo: _styleSegmentedControl.bottomAnchor, constant: 12),
            _dividerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            _dividerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        let appearance = NSAppearance.current(in: self)
        _fontComboBox.appearance = appearance
        _fontSizeSlider.appearance = appearance
        _fontStepper.appearance = appearance
        _fontTextField.appearance = appearance
        _styleSegmentedControl.appearance = appearance
    }
}
