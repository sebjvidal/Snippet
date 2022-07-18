//
//  SNWindowSettingsOpacityTableCellView.swift
//  Snippet
//
//  Created by Seb Vidal on 06/07/2022.
//

import Cocoa

class SNWindowSettingsOpacityTableCellView: NSTableRowView, SNSettingsTableCellView {
    var height: CGFloat = 69
    
    private var _titleLabel: SNLabel!
    private var _opacitySlider: NSSlider!
    private var _decreaseOpacityButton: NSButton!
    private var _increaseOpacityButton: NSButton!
    private var _dividerView: SNSettingsDividerView!
    
    init() {
        super.init(frame: NSRect.zero)
        _setupTitleLabel()
        _setupSlider()
        _setupOpacityButtons()
        _setupDividerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _setupTitleLabel() {
        _titleLabel = SNLabel()
        _titleLabel.text = "Opacity:"
        _titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_titleLabel)
        
        NSLayoutConstraint.activate([
            _titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            _titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18)
        ])
    }
    
    private func _setupSlider() {
        _opacitySlider = NSSlider()
        _opacitySlider.minValue = 0
        _opacitySlider.maxValue = 1
        _opacitySlider.doubleValue = 0.5
        _opacitySlider.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_opacitySlider)
        
        NSLayoutConstraint.activate([
            _opacitySlider.topAnchor.constraint(equalTo: _titleLabel.bottomAnchor, constant: 10)
        ])
    }
    
    private func _setupOpacityButtons() {
        let config = NSImage.SymbolConfiguration(pointSize: 13, weight: .regular)
        
        _decreaseOpacityButton = NSButton()
        _decreaseOpacityButton.isBordered = false
        _decreaseOpacityButton.contentTintColor = .labelColor
        _decreaseOpacityButton.image = NSImage(systemSymbolName: "circle.lefthalf.filled")?.withSymbolConfiguration(config)
        _decreaseOpacityButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_decreaseOpacityButton)
        
        NSLayoutConstraint.activate([
            _decreaseOpacityButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            _decreaseOpacityButton.centerYAnchor.constraint(equalTo: _opacitySlider.centerYAnchor),
            _decreaseOpacityButton.trailingAnchor.constraint(equalTo: _opacitySlider.leadingAnchor, constant: -10)
        ])
        
        _increaseOpacityButton = NSButton()
        _increaseOpacityButton.isBordered = false
        _increaseOpacityButton.contentTintColor = .labelColor
        _increaseOpacityButton.image = NSImage(systemSymbolName: "circle.fill")?.withSymbolConfiguration(config)
        _increaseOpacityButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_increaseOpacityButton)
        
        NSLayoutConstraint.activate([
            _increaseOpacityButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            _increaseOpacityButton.centerYAnchor.constraint(equalTo: _opacitySlider.centerYAnchor),
            _increaseOpacityButton.leadingAnchor.constraint(equalTo: _opacitySlider.trailingAnchor, constant: 10)
        ])
    }
    
    private func _setupDividerView() {
        _dividerView = SNSettingsDividerView()
        _dividerView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_dividerView)
        
        NSLayoutConstraint.activate([
            _dividerView.topAnchor.constraint(equalTo: _opacitySlider.bottomAnchor, constant: 12),
            _dividerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            _dividerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
