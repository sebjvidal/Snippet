//
//  SNEditorSettingsLanguageTableCellView.swift
//  Snippet
//
//  Created by Seb Vidal on 07/07/2022.
//

import Cocoa

class SNEditorSettingsLanguageTableCellView: NSTableRowView, SNSettingsTableCellView {
    var height: CGFloat = 69
    
    private var _titleLabel: SNLabel!
    private var _themeComboBox: NSPopUpButton!
    private var _dividerView: SNSettingsDividerView!
    
    init() {
        super.init(frame: NSRect.zero)
        _setupTitleLabel()
        _setupLanguageComboBox()
        _setupDividerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _setupTitleLabel() {
        _titleLabel = SNLabel()
        _titleLabel.text = "Language:"
        _titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_titleLabel)
        
        NSLayoutConstraint.activate([
            _titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            _titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18)
        ])
    }
    
    private func _setupLanguageComboBox() {
        _themeComboBox = NSPopUpButton()
        _themeComboBox.addItems(withTitles: ["JavaScript", "Python", "Swift", "TypeScript"])
        _themeComboBox.translatesAutoresizingMaskIntoConstraints = false

        addSubview(_themeComboBox)

        NSLayoutConstraint.activate([
            _themeComboBox.topAnchor.constraint(equalTo: _titleLabel.bottomAnchor, constant: 10),
            _themeComboBox.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            _themeComboBox.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18)
        ])
    }
    
    private func _setupDividerView() {
        _dividerView = SNSettingsDividerView()
        _dividerView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_dividerView)
        
        NSLayoutConstraint.activate([
            _dividerView.topAnchor.constraint(equalTo: _themeComboBox.bottomAnchor, constant: 12),
            _dividerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            _dividerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        _themeComboBox.appearance = .current(in: self)
    }
}
