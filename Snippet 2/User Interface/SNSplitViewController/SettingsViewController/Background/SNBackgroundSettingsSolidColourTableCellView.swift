//
//  SNBackgroundSettingsSolidColourTableCellView.swift
//  Snippet
//
//  Created by Seb Vidal on 10/07/2022.
//

import Cocoa

class SNBackgroundSettingsSolidColourTableCellView: NSTableRowView, SNSettingsTableCellView, SNColourPickerDelegate {
    var height: CGFloat = 275
    
    private var _titleLabel: SNLabel!
    private var _presetButton1: SNButton!
    private var _presetButton2: SNButton!
    private var _presetButton3: SNButton!
    private var _presetButton4: SNButton!
    private var _presetButton5: SNButton!
    private var _presetButton6: SNButton!
    private var _firstDividerView: SNSettingsDividerView!
    private var _customLabel: SNLabel!
    private var _colourPickerButton: NSButton!
    private var _customButton: SNButton!
    private var _recentButtons: [SNButton] = []
    private var _lastDividerView: SNSettingsDividerView!
    
    // MARK: Init
    init() {
        super.init(frame: NSRect.zero)
        _setupTitleLabel()
        _setupPresetButtons()
        _setupFirstDividerView()
        _setupCustomLabel()
        _setupColourPickerButton()
        _setupCustomButton()
        _setupRecentButtons()
        _setupLastDividerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _setupTitleLabel() {
        _titleLabel = SNLabel()
        _titleLabel.text = "Presets:"
        _titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_titleLabel)
        
        NSLayoutConstraint.activate([
            _titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            _titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18)
        ])
    }
    
    private func _setupPresetButtons() {
        _presetButton1 = SNButton()
        _presetButton1.isSelectable = true
        _presetButton1.selectionGroup = "solidColour"
        _presetButton1.view = .colour(from: .presets[0])
        _presetButton1.isSelected = CacheManager.shared.solidColour.preset == 0
        _presetButton1.action = {
            CacheManager.shared.setSolidColour(to: .presets[0])
            CanvasManager.shared.setBackground(to: SNSolidColour.presets[0])
        }
        
        _presetButton2 = SNButton()
        _presetButton2.isSelectable = true
        _presetButton2.selectionGroup = "solidColour"
        _presetButton2.view = .colour(from: .presets[1])
        _presetButton2.isSelected = CacheManager.shared.solidColour.preset == 1
        _presetButton2.action = {
            CacheManager.shared.setSolidColour(to: .presets[1])
            CanvasManager.shared.setBackground(to: SNSolidColour.presets[1])
        }
        
        _presetButton3 = SNButton()
        _presetButton3.isSelectable = true
        _presetButton3.selectionGroup = "solidColour"
        _presetButton3.view = .colour(from: .presets[2])
        _presetButton3.isSelected = CacheManager.shared.solidColour.preset == 2
        _presetButton3.action = {
            CacheManager.shared.setSolidColour(to: .presets[2])
            CanvasManager.shared.setBackground(to: SNSolidColour.presets[2])
        }
        
        _presetButton4 = SNButton()
        _presetButton4.isSelectable = true
        _presetButton4.selectionGroup = "solidColour"
        _presetButton4.view = .colour(from: .presets[3])
        _presetButton4.isSelected = CacheManager.shared.solidColour.preset == 3
        _presetButton4.action = {
            CacheManager.shared.setSolidColour(to: .presets[3])
            CanvasManager.shared.setBackground(to: SNSolidColour.presets[3])
        }
        
        _presetButton5 = SNButton()
        _presetButton5.isSelectable = true
        _presetButton5.selectionGroup = "solidColour"
        _presetButton5.view = .colour(from: .presets[4])
        _presetButton5.isSelected = CacheManager.shared.solidColour.preset == 4
        _presetButton5.action = {
            CacheManager.shared.setSolidColour(to: .presets[4])
            CanvasManager.shared.setBackground(to: SNSolidColour.presets[4])
        }
        
        _presetButton6 = SNButton()
        _presetButton6.isSelectable = true
        _presetButton6.selectionGroup = "solidColour"
        _presetButton6.view = .colour(from: .presets[5])
        _presetButton6.isSelected = CacheManager.shared.solidColour.preset == 5
        _presetButton6.action = {
            CacheManager.shared.setSolidColour(to: .presets[5])
            CanvasManager.shared.setBackground(to: SNSolidColour.presets[5])
        }
        
        addSubview(_presetButton1)
        addSubview(_presetButton2)
        addSubview(_presetButton3)
        addSubview(_presetButton4)
        addSubview(_presetButton5)
        addSubview(_presetButton6)
    }
    
    private func _setupFirstDividerView() {
        _firstDividerView = SNSettingsDividerView()
        _firstDividerView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(_firstDividerView)

        NSLayoutConstraint.activate([
            _firstDividerView.topAnchor.constraint(equalTo: _presetButton4.bottomAnchor, constant: 12),
            _firstDividerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            _firstDividerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func _setupCustomLabel() {
        _customLabel = SNLabel()
        _customLabel.text = "Custom:"
        _customLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_customLabel)
        
        NSLayoutConstraint.activate([
            _customLabel.topAnchor.constraint(equalTo: _firstDividerView.bottomAnchor, constant: 12),
            _customLabel.leadingAnchor.constraint(equalTo: _titleLabel.leadingAnchor)
        ])
    }
    
    private func _setupColourPickerButton() {
        _colourPickerButton = NSButton()
        _colourPickerButton.title = ""
        _colourPickerButton.target = self
        _colourPickerButton.bezelStyle = .regularSquare
        _colourPickerButton.action = #selector(_showColourPicker)
        _colourPickerButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_colourPickerButton)
        
        NSLayoutConstraint.activate([
            _colourPickerButton.topAnchor.constraint(equalTo: _customLabel.bottomAnchor, constant: 10),
            _colourPickerButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            _colourPickerButton.widthAnchor.constraint(equalToConstant: 58),
            _colourPickerButton.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        let arrowImage = NSImageView(image: NSImage(named: "ArrowDown")!)
        arrowImage.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(arrowImage)
        
        NSLayoutConstraint.activate([
            arrowImage.centerYAnchor.constraint(equalTo: _colourPickerButton.centerYAnchor),
            arrowImage.trailingAnchor.constraint(equalTo: _colourPickerButton.trailingAnchor, constant: -4)
        ])
    }
    
    @objc private func _showColourPicker(_ sender: NSView) {
        let colourPicker = SNColourPickerViewController()
        colourPicker.delegate = self
        
        let popover = NSPopover()
        popover.behavior = .transient
        popover.contentViewController = colourPicker
        popover.show(relativeTo: sender.bounds.with(x: 42), of: sender, preferredEdge: .maxY)
    }
    
    private func _setupCustomButton() {
        _customButton = SNButton()
        _customButton.cornerRadius = 3.5
        _customButton.isSelectable = true
        _customButton.selectionGroup = "solidColour"
        _customButton.view = .colour(from: .presets[0])
        _customButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_customButton)
        
        NSLayoutConstraint.activate([
            _customButton.topAnchor.constraint(equalTo: _colourPickerButton.topAnchor, constant: 3),
            _customButton.leadingAnchor.constraint(equalTo: _colourPickerButton.leadingAnchor, constant: 3),
            _customButton.bottomAnchor.constraint(equalTo: _colourPickerButton.bottomAnchor, constant: -3),
            _customButton.widthAnchor.constraint(equalTo: _customButton.heightAnchor)
        ])
    }
    
    private func _setupRecentButtons() {
        for _ in 0...15 {
            let button = SNButton()
//            button.view = .colour(from: .presets[0])
            
            _recentButtons.append(button)
            addSubview(button)
        }
    }
    
    private func _setupLastDividerView() {
        _firstDividerView = SNSettingsDividerView()
        _firstDividerView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_firstDividerView)
        
        NSLayoutConstraint.activate([
            _firstDividerView.topAnchor.constraint(equalTo: _colourPickerButton.bottomAnchor, constant: 12),
            _firstDividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            _firstDividerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    // MARK: Layout
    override func layout() {
        super.layout()
        _layoutPresetButtons()
        _layoutRecentButtons()
    }
    
    private func _layoutPresetButtons() {
        let y1: CGFloat = _titleLabel.frame.maxY + 10.0
        let width: CGFloat = (frame.width - 36 - 20) / 3
        
        _presetButton1.frame = CGRect(x: 18, y: y1, width: width, height: 60)
        _presetButton2.frame = CGRect(x: _presetButton1.frame.maxX + 10, y: y1, width: width, height: 60)
        _presetButton3.frame = CGRect(x: _presetButton2.frame.maxX + 10, y: y1, width: width, height: 60)
        
        let y2: CGFloat = _presetButton1.frame.maxY + 10.0
        _presetButton4.frame = CGRect(x: 18, y: y2, width: width, height: 60)
        _presetButton5.frame = CGRect(x: _presetButton1.frame.maxX + 10, y: y2, width: width, height: 60)
        _presetButton6.frame = CGRect(x: _presetButton2.frame.maxX + 10, y: y2, width: width, height: 60)
    }
    
    private func _layoutRecentButtons() {
        let xDatum = 18 + _colourPickerButton.frame.width + 5
        let yDatum = _colourPickerButton.frame.minY + 2
        let width = ((frame.width - (18 * 2) - _colourPickerButton.frame.width - (5 * 8)) / 8)
        
        for (potential, button) in _recentButtons.enumerated() {
            let index = potential > 7 ? potential - 8 : potential
            let x: CGFloat = xDatum + (width * CGFloat(index)) + (5 * CGFloat(index))
            let y: CGFloat = potential > 7 ? yDatum + 26 : yDatum
            button.frame = CGRect(x: x, y: y, width: CGFloat(Int(width)), height: 20)
        }
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        _colourPickerButton.appearance = .current(in: self)
    }
}
