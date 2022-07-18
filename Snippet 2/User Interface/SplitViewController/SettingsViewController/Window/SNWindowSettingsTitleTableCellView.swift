//
//  SNWindowSettingsTitleTableCellView.swift
//  Snippet
//
//  Created by Seb Vidal on 05/07/2022.
//

import Cocoa

class SNWindowSettingsTitleTableCellView: NSTableRowView, SNSettingsTableCellView {
    var height: CGFloat = 97
    
    private var _titleLabel: SNLabel!
    private var _titleTextField: NSTextField!
    private var _showIconCheckBox: NSButton!
    private var _dividerView: SNSettingsDividerView!
    
    init() {
        super.init(frame: NSRect.zero)
        _setupTitleLabel()
        _setupTitleTextField()
        _setupShowIconCheckBox()
        _setupDividerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        _titleTextField.appearance = .current(in: self)
        _showIconCheckBox.appearance = .current(in: self)
    }
    
    private func _setupTitleLabel() {
        _titleLabel = SNLabel()
        _titleLabel.text = "Title:"
        _titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_titleLabel)
        
        NSLayoutConstraint.activate([
            _titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            _titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18)
        ])
    }
    
    private func _setupTitleTextField() {
        _titleTextField = NSTextField()
        _titleTextField.stringValue = "Untitled"
        _titleTextField.bezelStyle = .roundedBezel
        _titleTextField.font = .systemFont(ofSize: 13)
        _titleTextField.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_titleTextField)
        
        NSLayoutConstraint.activate([
            _titleTextField.topAnchor.constraint(equalTo: _titleLabel.bottomAnchor, constant: 10),
            _titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            _titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18)
        ])
    }
    
    private func _setupShowIconCheckBox() {
        _showIconCheckBox = NSButton()
        _showIconCheckBox.title = "Show Icon"
        _showIconCheckBox.setButtonType(.switch)
        _showIconCheckBox.font = .systemFont(ofSize: 13)
        _showIconCheckBox.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_showIconCheckBox)
        
        NSLayoutConstraint.activate([
            _showIconCheckBox.topAnchor.constraint(equalTo: _titleTextField.bottomAnchor, constant: 10),
            _showIconCheckBox.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18 + 1.5) // +1.5 for visual alignment
        ])
    }
    
    private func _setupDividerView() {
        _dividerView = SNSettingsDividerView()
        _dividerView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_dividerView)
        
        NSLayoutConstraint.activate([
            _dividerView.topAnchor.constraint(equalTo: _showIconCheckBox.bottomAnchor, constant: 12),
            _dividerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            _dividerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
