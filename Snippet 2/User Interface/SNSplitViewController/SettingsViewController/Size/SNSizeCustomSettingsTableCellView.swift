//
//  SNSizeCustomSettingsTableCellView.swift
//  Snippet
//
//  Created by Seb Vidal on 31/07/2022.
//

import Cocoa

class SNSizeCustomSettingsTableCellView: NSTableRowView, SNSettingsTableCellView, NSTextFieldDelegate {
    var height: CGFloat = 109
    
    private var _titleLabel: SNLabel!
    private var _customButton: SNButton!
    private var _widthLabel: SNLabel!
    private var _heightLabel: SNLabel!
    private var _widthStepper: NSStepper!
    private var _heightStepper: NSStepper!
    private var _widthTextField: NSTextField!
    private var _heightTextField: NSTextField!
    private var _dividerView: SNSettingsDividerView!
    
    // MARK: init()
    init() {
        super.init(frame: NSRect.zero)
        _setupTitleLabel()
        _setupCustomButton()
        _setupWidthHeightLabel()
        _setupWidthHeightStepper()
        _setupWidthHeighTextField()
        _setupDividerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _setupTitleLabel() {
        _titleLabel = SNLabel()
        _titleLabel.text = "Custom:"
        _titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_titleLabel)
        
        NSLayoutConstraint.activate([
            _titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            _titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18)
        ])
    }
    
    private var _aspectRatio = CacheManager.shared.aspectRatio
    
    private func _setupCustomButton() {
        _customButton = SNButton()
        _customButton.isSelectable = true
        _customButton.selectionGroup = "aspectRatio"
        _customButton.view = .aspectRatio(from: _aspectRatio)
        _customButton.isSelected = CacheManager.shared.aspectRatio.preset == nil

        addSubview(_customButton)
    }
    
    private func _setupWidthHeightLabel() {
        _widthLabel = SNLabel()
        _widthLabel.text = "W"
        _widthLabel.translatesAutoresizingMaskIntoConstraints = false
        _widthLabel.font = .systemFont(ofSize: 15, weight: .bold, design: .rounded)
        
        _heightLabel = SNLabel()
        _heightLabel.text = "H"
        _heightLabel.translatesAutoresizingMaskIntoConstraints = false
        _heightLabel.font = .systemFont(ofSize: 15, weight: .bold, design: .rounded)
        
        addSubview(_widthLabel)
        addSubview(_heightLabel)
        
        NSLayoutConstraint.activate([
            _widthLabel.topAnchor.constraint(equalTo: _customButton.topAnchor, constant: 5),
            _widthLabel.leadingAnchor.constraint(equalTo: _customButton.trailingAnchor, constant: 10),
            
            _heightLabel.bottomAnchor.constraint(equalTo: _customButton.bottomAnchor, constant: -5),
            _heightLabel.centerXAnchor.constraint(equalTo: _widthLabel.centerXAnchor, constant: 0.5)
        ])
    }
    
    private func _setupWidthHeightStepper() {
        _widthStepper = NSStepper()
        _widthStepper.translatesAutoresizingMaskIntoConstraints = false
        
        _heightStepper = NSStepper()
        _heightStepper.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_widthStepper)
        addSubview(_heightStepper)
        
        NSLayoutConstraint.activate([
            _widthStepper.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            _heightStepper.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18)
        ])
    }
    
    private func _setupWidthHeighTextField() {
        _widthTextField = NSTextField()
        _heightTextField = NSTextField()
        
        _widthTextField.delegate = self
        _widthTextField.bezelStyle = .roundedBezel
        _widthTextField.nextKeyView = _heightTextField
        _widthTextField.translatesAutoresizingMaskIntoConstraints = false
        
        _heightTextField.delegate = self
        _heightTextField.bezelStyle = .roundedBezel
        _heightTextField.nextKeyView = _widthTextField
        _heightTextField.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_widthTextField)
        addSubview(_heightTextField)
        
        NSLayoutConstraint.activate([
            _widthTextField.centerYAnchor.constraint(equalTo: _widthLabel.centerYAnchor),
            _widthTextField.leadingAnchor.constraint(equalTo: _widthLabel.trailingAnchor, constant: 10),
            _widthTextField.trailingAnchor.constraint(equalTo: _widthStepper.leadingAnchor, constant: -2),
            _widthTextField.centerYAnchor.constraint(equalTo: _widthStepper.centerYAnchor),
            
            _heightTextField.centerYAnchor.constraint(equalTo: _heightLabel.centerYAnchor),
            _heightTextField.leadingAnchor.constraint(equalTo: _heightLabel.trailingAnchor, constant: 10),
            _heightTextField.trailingAnchor.constraint(equalTo: _heightStepper.leadingAnchor, constant: -2),
            _heightTextField.centerYAnchor.constraint(equalTo: _heightStepper.centerYAnchor),
        ])
    }
    
    func controlTextDidChange(_ obj: Notification) {
        let aspectRatio = CacheManager.shared.customAspectRatio
        _customButton.perform(Selector(("_invalidateOthers")))
        _customButton.isSelected = true
        
        if let textField = obj.object as? NSTextField {
            if textField == _widthTextField {
                aspectRatio.width = textField.doubleValue
            } else if textField == _heightTextField {
                aspectRatio.height = textField.doubleValue
            }
            
            _customButton.view = .aspectRatio(from: aspectRatio)
        }
    }
    
    private func _setupDividerView() {
        _dividerView = SNSettingsDividerView()
        _dividerView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(_dividerView)

        NSLayoutConstraint.activate([
            _dividerView.topAnchor.constraint(equalTo: _customButton.bottomAnchor, constant: 12),
            _dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            _dividerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    override func layout() {
        super.layout()
        let y: CGFloat = _titleLabel.frame.maxY + 10.0
        let width: CGFloat = (frame.width - 36 - 20) / 3
        _customButton.frame = CGRect(x: 18, y: y, width: width, height: 60)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        let appearance = NSAppearance.current(in: self)
        _widthStepper.appearance = appearance
        _heightStepper.appearance = appearance
        _widthTextField.appearance = appearance
        _heightTextField.appearance = appearance
    }
}
