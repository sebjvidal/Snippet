//
//  SNWindowSettingsAppearanceTableCellView.swift
//  Snippet
//
//  Created by Seb Vidal on 05/07/2022.
//

import Cocoa
import SwiftUI

class SNWindowSettingsAppearanceTableCellView: NSTableRowView, SNSettingsTableCellView {
    var height: CGFloat = 130
    
    private var _titleLabel: SNLabel!
    private var _automaticButton: SNButton!
    private var _lightButton: SNButton!
    private var _darkButton: SNButton!
    private var _dividerView: SNSettingsDividerView!
    
    // MARK: Init
    init() {
        super.init(frame: NSRect.zero)
        _setupTitleLabel()
        _setupButtons()
        _setupDividerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _setupTitleLabel() {
        _titleLabel = SNLabel()
        _titleLabel.text = "Appearance:"
        _titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_titleLabel)
        
        NSLayoutConstraint.activate([
            _titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            _titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18)
        ])
    }
    
    private func _setupButtons() {
        _automaticButton = SNButton()
        _automaticButton.label = "Automatic"
        _automaticButton.isSelectable = true
        _automaticButton.view = .automaticAppearance
        _automaticButton.selectionGroup = "appearance"
        _automaticButton.isSelected = CacheManager.shared.appearance == nil
        _automaticButton.action = {
            CacheManager.shared.setAppearance(to: nil)
            CanvasManager.shared.setAppearance(to: nil)
        }
        
        _lightButton = SNButton()
        _lightButton.label = "Light"
        _lightButton.isSelectable = true
        _lightButton.view = .lightAppearance
        _lightButton.selectionGroup = "appearance"
        _lightButton.isSelected = CacheManager.shared.appearance == .aqua
        _lightButton.action = {
            CacheManager.shared.setAppearance(to: .aqua)
            CanvasManager.shared.setAppearance(to: .aqua)
        }
        
        _darkButton = SNButton()
        _darkButton.label = "Dark"
        _darkButton.isSelectable = true
        _darkButton.view = .darkAppearance
        _darkButton.selectionGroup = "appearance"
        _darkButton.isSelected = CacheManager.shared.appearance == .darkAqua
        _darkButton.action = {
            CacheManager.shared.setAppearance(to: .darkAqua)
            CanvasManager.shared.setAppearance(to: .darkAqua)
        }
        
        addSubview(_automaticButton)
        addSubview(_lightButton)
        addSubview(_darkButton)
    }
    
    // MARK: Layout
    override func layout() {
        super.layout()
        _layoutButtons()
    }
    
    private func _layoutButtons() {
        let y: CGFloat = _titleLabel.frame.maxY + 10.0
        let width: CGFloat = (frame.width - 36 - 20) / 3
        
        _automaticButton.frame = CGRect(x: 18, y: y, width: width, height: 60)
        _lightButton.frame = CGRect(x: _automaticButton.frame.maxX + 10, y: y, width: width, height: 60)
        _darkButton.frame = CGRect(x: _lightButton.frame.maxX + 10, y: y, width: width, height: 60)
    }
    
    private func _setupDividerView() {
        _dividerView = SNSettingsDividerView()
        _dividerView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(_dividerView)

        NSLayoutConstraint.activate([
            _dividerView.topAnchor.constraint(equalTo: _automaticButton.bottomAnchor, constant: 33),
            _dividerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            _dividerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    // MARK: Draw
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        let appearance = NSAppearance.current(in: self)
        _automaticButton.appearance = appearance
        _lightButton.appearance = appearance
        _darkButton.appearance = appearance
    }
}
