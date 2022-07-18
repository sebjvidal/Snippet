//
//  SNWindowSettingsControlsTableCellView.swift
//  Snippet
//
//  Created by Seb Vidal on 06/07/2022.
//

import Cocoa

class SNWindowSettingsControlsTableCellView: NSTableRowView, SNSettingsTableCellView {
    var height: CGFloat = 130
    
    private var _titleLabel: SNLabel!
    private var _colourfulButton: SNButton!
    private var _graphiteButton: SNButton!
    private var _noneButton: SNButton!
    private var _dividerView: SNSettingsDividerView!
    
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
        _titleLabel.text = "Controls:"
        _titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_titleLabel)
        
        NSLayoutConstraint.activate([
            _titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            _titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18)
        ])
    }
    
    private func _setupButtons() {
        _colourfulButton = SNButton()
        _colourfulButton.label = "Colourful"
        _colourfulButton.isSelectable = true
        _colourfulButton.view = .colourfulControls
        
        _graphiteButton = SNButton()
        _graphiteButton.label = "Graphite"
        _graphiteButton.isSelectable = true
        _graphiteButton.view = .graphiteControls
        
        _noneButton = SNButton()
        _noneButton.label = "None"
        _noneButton.isSelectable = true
        _noneButton.view = .noneControls
        
        addSubview(_colourfulButton)
        addSubview(_graphiteButton)
        addSubview(_noneButton)
    }
    
    // MARK: Layout
    override func layout() {
        super.layout()
        _layoutButtons()
    }
    
    private func _layoutButtons() {
        let y: CGFloat = _titleLabel.frame.maxY + 10.0
        let width: CGFloat = (frame.width - 36 - 20) / 3
        let height: CGFloat = 60
        
        _colourfulButton.frame = CGRect(x: 18, y: y, width: width, height: height)
        _graphiteButton.frame = CGRect(x: _colourfulButton.frame.maxX + 10, y: y, width: width, height: height)
        _noneButton.frame = CGRect(x: _graphiteButton.frame.maxX + 10, y: y, width: width, height: height)
    }
    
    private func _setupDividerView() {
        _dividerView = SNSettingsDividerView()
        _dividerView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_dividerView)
        
        NSLayoutConstraint.activate([
            _dividerView.topAnchor.constraint(equalTo: _colourfulButton.bottomAnchor, constant: 33),
            _dividerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            _dividerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
