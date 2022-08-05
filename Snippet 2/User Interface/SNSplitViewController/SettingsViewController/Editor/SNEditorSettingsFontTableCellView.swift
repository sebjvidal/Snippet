//
//  SNEditorSettingsFontTableCellView.swift
//  Snippet
//
//  Created by Seb Vidal on 07/07/2022.
//

import Cocoa

class SNEditorSettingsFontTableCellView: NSTableRowView, SNSettingsTableCellView, NSTextFieldDelegate {
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
        _fontComboBox.target = self
        _fontComboBox.action = #selector(_fontComboBoxValueChanged)
        _fontComboBox.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_fontComboBox)
        
        NSLayoutConstraint.activate([
            _fontComboBox.topAnchor.constraint(equalTo: _titleLabel.bottomAnchor, constant: 10),
            _fontComboBox.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            _fontComboBox.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18)
        ])
        
        for (index, font) in CacheManager.shared.fonts.keys.sorted().enumerated() {
            _fontComboBox.addItem(withTitle: font)
            
            if font == CacheManager.shared.font {
                _fontComboBox.selectItem(at: index)
            }
        }
    }
    
    @objc private func _fontComboBoxValueChanged() {
        if let font = _fontComboBox.selectedItem?.title {
            CacheManager.shared.setFont(to: font)
        }
    }
    
    private func _setupFontStepper() {
        _fontStepper = NSStepper()
        _fontStepper.minValue = 10
        _fontStepper.maxValue = 30
        _fontStepper.target = self
        _fontStepper.valueWraps = false
        _fontStepper.action = #selector(_fontStepperValueChanged)
        _fontStepper.integerValue = Int(CacheManager.shared.fontSize)
        _fontStepper.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_fontStepper)
        
        NSLayoutConstraint.activate([
            _fontStepper.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            _fontStepper.topAnchor.constraint(equalTo: _fontComboBox.bottomAnchor, constant: 10)
        ])
    }
    
    @objc private func _fontStepperValueChanged() {
        _fontTextField.integerValue = _fontStepper.integerValue
        _fontSizeSlider.integerValue = _fontStepper.integerValue
        CacheManager.shared.setFontSize(to: _fontStepper.floatValue.cgFloat)
    }
    
    private func _setupFontTextField() {
        _fontTextField = NSTextField()
        _fontTextField.delegate = self
        _fontTextField.alignment = .center
        _fontTextField.bezelStyle = .roundedBezel
        _fontTextField.formatter = SNIntegerNumberFormatter()
        _fontTextField.integerValue = Int(CacheManager.shared.fontSize)
        _fontTextField.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_fontTextField)
        
        NSLayoutConstraint.activate([
            _fontTextField.trailingAnchor.constraint(equalTo: _fontStepper.leadingAnchor, constant: -2),
            _fontTextField.centerYAnchor.constraint(equalTo: _fontStepper.centerYAnchor),
            _fontTextField.widthAnchor.constraint(equalToConstant: 42)
        ])
    }
    
    func controlTextDidEndEditing(_ obj: Notification) {
        if _fontTextField.stringValue.isEmpty {
            _fontTextField.integerValue = Int(CacheManager.shared.fontSize)
        }
        
        if _fontTextField.integerValue < 10 {
            _fontTextField.integerValue = 10
        } else if _fontTextField.integerValue > 30 {
            _fontTextField.integerValue = 30
        }
        
        CacheManager.shared.setFontSize(to: _fontTextField.floatValue.cgFloat)
        _fontStepper.integerValue = _fontTextField.integerValue
        _fontSizeSlider.integerValue = _fontTextField.integerValue
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
        _fontSizeSlider.target = self
        _fontSizeSlider.minValue = 10
        _fontSizeSlider.maxValue = 30
        _fontSizeSlider.intValue = 15
        _fontSizeSlider.numberOfTickMarks = 21
        _fontSizeSlider.allowsTickMarkValuesOnly = true
        _fontSizeSlider.action = #selector(_fontSizeSliderValueChanged)
        _fontSizeSlider.integerValue = Int(CacheManager.shared.fontSize)
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
    
    @objc private func _fontSizeSliderValueChanged() {
        _fontStepper.integerValue = _fontSizeSlider.integerValue
        _fontTextField.integerValue = _fontSizeSlider.integerValue
    }
    
    private func _setupStyleSegmentedControl() {
        _styleSegmentedControl = NSSegmentedControl()
        _styleSegmentedControl.target = self
        _styleSegmentedControl.segmentCount = 4
        _styleSegmentedControl.trackingMode = .selectAny
        _styleSegmentedControl.setImage(NSImage(systemSymbolName: "bold"), forSegment: 0)
        _styleSegmentedControl.setImage(NSImage(systemSymbolName: "italic"), forSegment: 1)
        _styleSegmentedControl.setImage(NSImage(systemSymbolName: "underline"), forSegment: 2)
        _styleSegmentedControl.setImage(NSImage(systemSymbolName: "strikethrough"), forSegment: 3)
        _styleSegmentedControl.action =  #selector(_styleSegmentedControlSelectionChanged)
        _styleSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_styleSegmentedControl)
        
        NSLayoutConstraint.activate([
            _styleSegmentedControl.topAnchor.constraint(equalTo: _fontTextField.bottomAnchor, constant: 10),
            _styleSegmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            _styleSegmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18)
        ])
        
        _styleSegmentedControl.setSelected(CacheManager.shared.bold, forSegment: 0)
        _styleSegmentedControl.setSelected(CacheManager.shared.italic, forSegment: 1)
        _styleSegmentedControl.setSelected(CacheManager.shared.underline, forSegment: 2)
        _styleSegmentedControl.setSelected(CacheManager.shared.strikethrough, forSegment: 3)
    }
    
    @objc private func _styleSegmentedControlSelectionChanged() {
        CacheManager.shared.setBold(to: _styleSegmentedControl.isSelected(forSegment: 0))
        CacheManager.shared.setItalic(to: _styleSegmentedControl.isSelected(forSegment: 1))
        CacheManager.shared.setUnderline(to: _styleSegmentedControl.isSelected(forSegment: 2))
        CacheManager.shared.setStrikethrough(to: _styleSegmentedControl.isSelected(forSegment: 3))
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
