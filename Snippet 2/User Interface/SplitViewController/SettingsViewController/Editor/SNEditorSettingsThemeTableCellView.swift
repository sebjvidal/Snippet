//
//  SNEditorSettingsThemeTableCellView.swift
//  Snippet
//
//  Created by Seb Vidal on 07/07/2022.
//

import Cocoa

class SNEditorSettingsThemeTableCellView: NSTableRowView, SNSettingsTableCellView {
    var height: CGFloat = 99
    
    private var _titleLabel: SNLabel!
    private var _languageComboBox: NSPopUpButton!
    private var _newButton: NSButton!
    private var _editButton: NSButton!
    private var _deleteButton: NSButton!
    private var _dividerView: SNSettingsDividerView!
    
    init() {
        super.init(frame: NSRect.zero)
        _setupTitleLabel()
        _setupThemeComboBox()
        _setupNewButton()
        _setupEditButton()
        _setupDeleteButton()
        _setupDividerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _setupTitleLabel() {
        _titleLabel = SNLabel()
        _titleLabel.text = "Theme:"
        _titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_titleLabel)
        
        NSLayoutConstraint.activate([
            _titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            _titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18)
        ])
    }
    
    private func _setupThemeComboBox() {
        _languageComboBox = NSPopUpButton()
        _languageComboBox.addItems(withTitles: ["JavaScript", "Python", "Swift", "TypeScript"])
        _languageComboBox.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_languageComboBox)
        
        NSLayoutConstraint.activate([
            _languageComboBox.topAnchor.constraint(equalTo: _titleLabel.bottomAnchor, constant: 10),
            _languageComboBox.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            _languageComboBox.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18)
        ])
    }
    
    private func _setupNewButton() {
        _newButton = NSButton()
        _newButton.title = " New"
        _newButton.bezelStyle = .rounded
        _newButton.imageHugsTitle = true
        _newButton.imagePosition = .imageLeft
        _newButton.font = .systemFont(ofSize: 13)
        _newButton.image = NSImage(systemSymbolName: "plus")
        
        addSubview(_newButton)
    }
    
    private func _setupEditButton() {
        _editButton = NSButton()
        _editButton.title = " Edit"
        _editButton.bezelStyle = .rounded
        _editButton.imageHugsTitle = true
        _editButton.imagePosition = .imageLeft
        _editButton.font = .systemFont(ofSize: 13)
        _editButton.image = NSImage(systemSymbolName: "pencil")
        
        addSubview(_editButton)
    }
    
    private func _setupDeleteButton() {
        _deleteButton = NSButton()
        _deleteButton.controlSize = .regular
        _deleteButton.title = " Delete"
        _deleteButton.bezelStyle = .rounded
        _deleteButton.imageHugsTitle = true
        _deleteButton.imagePosition = .imageLeft
        _deleteButton.font = .systemFont(ofSize: 13)
        _deleteButton.image = NSImage(systemSymbolName: "trash")
        
        addSubview(_deleteButton)
    }
    
    private func _setupDividerView() {
        _dividerView = SNSettingsDividerView()
        _dividerView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_dividerView)
        
        NSLayoutConstraint.activate([
            _dividerView.topAnchor.constraint(equalTo: _newButton.bottomAnchor, constant: 16),
            _dividerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            _dividerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    override func layout() {
        super.layout()
        
        let y: CGFloat = _languageComboBox.frame.maxY + 6
        let width: CGFloat = (frame.width - 22 + 10) / 3
        let height: CGFloat = 23
        
        _newButton.frame = CGRect(x: 11, y: y, width: width, height: height)
        _editButton.frame = CGRect(x: _newButton.frame.maxX - 5, y: y, width: width, height: height)
        _deleteButton.frame = CGRect(x: _editButton.frame.maxX - 5, y: y, width: width, height: height)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        let appearance = NSAppearance.current(in: self)
        _languageComboBox.appearance = appearance
        _newButton.appearance = appearance
        _editButton.appearance = appearance
        _deleteButton.appearance = appearance
    }
}
