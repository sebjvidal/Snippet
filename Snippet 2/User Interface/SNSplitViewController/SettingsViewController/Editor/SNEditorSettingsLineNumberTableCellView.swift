//
//  SNEditorSettingsLineNumberTableCellView.swift
//  Snippet
//
//  Created by Seb Vidal on 08/07/2022.
//

import Cocoa

class SNEditorSettingsLineNumberTableCellView: NSTableRowView, SNSettingsTableCellView, NSTextFieldDelegate {
    var height: CGFloat = 71
    
    private var _titleLabel: SNLabel!
    private var _lineNumberCheckbox: NSSwitch!
    private var _lineNumberLabel: SNLabel!
    private var _lineNumberTextField: NSTextField!
    private var _lineNumberStepper: NSStepper!
    private var _dividerView: SNSettingsDividerView!
    
    init() {
        super.init(frame: NSRect.zero)
        _setupTitleLabel()
        _setupLineNumberCheckBox()
        _setupLineNumberLabel()
        _setupLineNumberTextField()
        _setupLineNumberStepper()
        _setupDividerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _setupTitleLabel() {
        _titleLabel = SNLabel()
        _titleLabel.text = "Line Numbers:"
        _titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_titleLabel)
        
        NSLayoutConstraint.activate([
            _titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            _titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18)
        ])
    }
    
    private func _setupLineNumberCheckBox() {
        _lineNumberCheckbox = NSSwitch()
        _lineNumberCheckbox.target = self
        _lineNumberCheckbox.controlSize = .small
        _lineNumberCheckbox.isOn = CacheManager.shared.enableLineNumbers
        _lineNumberCheckbox.translatesAutoresizingMaskIntoConstraints = false
        _lineNumberCheckbox.action = #selector(_lineNumberCheckboxValueChanged)
        
        addSubview(_lineNumberCheckbox)
        
        NSLayoutConstraint.activate([
            _lineNumberCheckbox.centerYAnchor.constraint(equalTo: _titleLabel.centerYAnchor),
            _lineNumberCheckbox.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18)
        ])
    }
    
    @objc private func _lineNumberCheckboxValueChanged() {
        CacheManager.shared.setEnableLineNumbers(to: _lineNumberCheckbox.isOn)
    }
    
    private func _setupLineNumberLabel() {
        _lineNumberLabel = SNLabel()
        _lineNumberLabel.text = "Start at:"
        _lineNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_lineNumberLabel)
        
        NSLayoutConstraint.activate([
            _lineNumberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18)
        ])
    }
    
    private func _setupLineNumberTextField() {
        _lineNumberTextField = NSTextField()
        _lineNumberTextField.target = self
        _lineNumberTextField.bezelStyle = .roundedBezel
        _lineNumberTextField.formatter = SNIntegerNumberFormatter()
        _lineNumberTextField.integerValue = CacheManager.shared.lineNumberStart
        _lineNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        _lineNumberTextField.action = #selector(_lineNumberTextFieldValueChanged)
        
        addSubview(_lineNumberTextField)
        
        NSLayoutConstraint.activate([
            _lineNumberTextField.centerYAnchor.constraint(equalTo: _lineNumberLabel.centerYAnchor),
            _lineNumberTextField.topAnchor.constraint(equalTo: _titleLabel.bottomAnchor, constant: 10),
            _lineNumberTextField.leadingAnchor.constraint(equalTo: _lineNumberLabel.trailingAnchor, constant: 10)
        ])
    }
    
    @objc private func _lineNumberTextFieldValueChanged() {
        if _lineNumberTextField.stringValue.isEmpty {
            _lineNumberTextField.integerValue = Int(CacheManager.shared.lineNumberStart)
        }
        
        CacheManager.shared.setLineNumberStart(to: _lineNumberTextField.integerValue)
        _lineNumberStepper.integerValue = _lineNumberTextField.integerValue
    }
    
    private func _setupLineNumberStepper() {
        _lineNumberStepper = NSStepper()
        _lineNumberStepper.minValue = 0
        _lineNumberStepper.target = self
        _lineNumberStepper.translatesAutoresizingMaskIntoConstraints = false
        _lineNumberStepper.action = #selector(_lineNumberStepperValueChanged)
        _lineNumberStepper.integerValue = CacheManager.shared.lineNumberStart
        
        addSubview(_lineNumberStepper)
        
        NSLayoutConstraint.activate([
            _lineNumberStepper.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            _lineNumberStepper.centerYAnchor.constraint(equalTo: _lineNumberTextField.centerYAnchor),
            _lineNumberStepper.leadingAnchor.constraint(equalTo: _lineNumberTextField.trailingAnchor, constant: 2)
        ])
    }
    
    @objc private func _lineNumberStepperValueChanged() {
        _lineNumberTextField.integerValue = _lineNumberStepper.integerValue
        CacheManager.shared.setLineNumberStart(to: _lineNumberStepper.integerValue)
    }
    
    private func _setupDividerView() {
        _dividerView = SNSettingsDividerView()
        _dividerView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(_dividerView)

        NSLayoutConstraint.activate([
            _dividerView.topAnchor.constraint(equalTo: _lineNumberTextField.bottomAnchor, constant: 12),
            _dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            _dividerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        _lineNumberTextField.appearance = .current(in: self)
        _lineNumberStepper.appearance = .current(in: self)
    }
}
