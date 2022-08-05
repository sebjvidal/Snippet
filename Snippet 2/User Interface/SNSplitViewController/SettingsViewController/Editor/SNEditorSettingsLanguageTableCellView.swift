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
    private var _languageComboBox: NSPopUpButton!
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
    
    private var _languages: [String] = []
    
    private func _setupLanguageComboBox() {
        _languageComboBox = NSPopUpButton()
        _languageComboBox.target = self
        _languageComboBox.action = #selector(_languageComboBoxValueChanged)
        _languageComboBox.translatesAutoresizingMaskIntoConstraints = false

        addSubview(_languageComboBox)

        NSLayoutConstraint.activate([
            _languageComboBox.topAnchor.constraint(equalTo: _titleLabel.bottomAnchor, constant: 10),
            _languageComboBox.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            _languageComboBox.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18)
        ])
        
        for (index, language) in CacheManager.shared.languages.keys.sorted().enumerated() {
            _languages.append(language)
            _languageComboBox.addItem(withTitle: language)
            
            if language == CacheManager.shared.language {
                _languageComboBox.selectItem(at: index)
            }
        }
    }
    
    @objc private func _languageComboBoxValueChanged() {
        if let language = _languageComboBox.selectedItem?.title {
            CacheManager.shared.setLanguage(to: language)
        }
    }
    
    private func _setupDividerView() {
        _dividerView = SNSettingsDividerView()
        _dividerView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_dividerView)
        
        NSLayoutConstraint.activate([
            _dividerView.topAnchor.constraint(equalTo: _languageComboBox.bottomAnchor, constant: 12),
            _dividerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            _dividerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        _languageComboBox.appearance = .current(in: self)
    }
}
