//
//  SNBackgroundSettingsBackgroundTableCellView.swift
//  Snippet
//
//  Created by Seb Vidal on 09/07/2022.
//

import Cocoa

class SNBackgroundSettingsBackgroundTableCellView: NSTableRowView, SNSettingsTableCellView {
    var height: CGFloat = 69
    var parent: SNBackgroundSettingsViewController
    
    private var _titleLabel: SNLabel!
    private var _backgroundComboBox: NSPopUpButton!
    private var _backgroundSwitch: NSSwitch!
    private var _dividerView: SNSettingsDividerView!
    
    init(parent: SNBackgroundSettingsViewController) {
        self.parent = parent
        super.init(frame: NSRect.zero)
        _setupTitleLabel()
        _setupLanguageComboBox()
        _setupBackgroundSwitch()
        _setupDividerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _setupTitleLabel() {
        _titleLabel = SNLabel()
        _titleLabel.text = "Background:"
        _titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_titleLabel)
        
        NSLayoutConstraint.activate([
            _titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            _titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18)
        ])
    }
    
    private func _setupLanguageComboBox() {
        _backgroundComboBox = NSPopUpButton()
        _backgroundComboBox.addItems(withTitles: ["Solid Colour", "Gradient", "Image"])
        _backgroundComboBox.translatesAutoresizingMaskIntoConstraints = false
        _backgroundComboBox.action = #selector(_comboBoxValueChanged(_:))
        _backgroundComboBox.target = self
        
        addSubview(_backgroundComboBox)
        
        NSLayoutConstraint.activate([
            _backgroundComboBox.topAnchor.constraint(equalTo: _titleLabel.bottomAnchor, constant: 10),
            _backgroundComboBox.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            _backgroundComboBox.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18)
        ])
        
        _backgroundComboBox.selectItem(withTitle: CacheManager.shared.backgroundType.rawValue)
    }
    
    @objc private func _comboBoxValueChanged(_ sender: NSPopUpButton) {
        let title = sender.selectedItem!.title
        let type = SNBackgroundType(rawValue: title) ?? .solidColour
        CacheManager.shared.setBackgroundType(to: type)
        CanvasManager.shared.setBackground(to: CacheManager.shared.background)
        parent.setAccessoryCell(to: type)
    }
    
    private func _setupBackgroundSwitch() {
        _backgroundSwitch = NSSwitch()
        _backgroundSwitch.controlSize = .small
        _backgroundSwitch.isOn = CacheManager.shared.backgroundEnabled
        _backgroundSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_backgroundSwitch)
        
        NSLayoutConstraint.activate([
            _backgroundSwitch.centerYAnchor.constraint(equalTo: _titleLabel.centerYAnchor),
            _backgroundSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18)
        ])
    }
    
    private func _setupDividerView() {
        _dividerView = SNSettingsDividerView()
        _dividerView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_dividerView)
        
        NSLayoutConstraint.activate([
            _dividerView.topAnchor.constraint(equalTo: _backgroundComboBox.bottomAnchor, constant: 12),
            _dividerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            _dividerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        _backgroundComboBox.appearance = .current(in: self)
    }
}
