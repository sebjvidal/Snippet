//
//  SNWindowSettingsPaddingTableCellView.swift
//  Snippet
//
//  Created by Seb Vidal on 06/07/2022.
//

import Cocoa

class SNWindowSettingsPaddingTableCellView: NSTableRowView, SNSettingsTableCellView {
    var height: CGFloat = 105
    
    private var _titleLabel: SNLabel!
    private var _hLabel: SNLabel!
    private var _vLabel: SNLabel!
    private var _paddingSwitch: NSSwitch!
    private var _hSegmentedControl: NSSegmentedControl!
    private var _vSegmentedControl: NSSegmentedControl!
    private var _linkedCheckBox: NSButton!
    private var _linkImageView: NSImageView!
    private var _dividerView: SNSettingsDividerView!
    
    init() {
        super.init(frame: NSRect.zero)
        _setupTitleLabel()
        _setupPaddingLabels()
        _setupPaddingSwitch()
        _setupSegmentedControls()
//        _setupLinkedCheckBox()
        _setupDividerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _setupTitleLabel() {
        _titleLabel = SNLabel()
        _titleLabel.text = "Padding:"
        _titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_titleLabel)
        
        NSLayoutConstraint.activate([
            _titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            _titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18)
        ])
    }
    
    private func _setupPaddingLabels() {
        _hLabel = SNLabel()
        _hLabel.font = .systemFont(ofSize: 15, weight: .bold, design: .rounded)
        _hLabel.text = "H"
        _hLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_hLabel)
        
        NSLayoutConstraint.activate([
            _hLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            _hLabel.widthAnchor.constraint(equalToConstant: 13)
        ])
        
        _vLabel = SNLabel()
        _vLabel.font = .systemFont(ofSize: 15, weight: .bold, design: .rounded)
        _vLabel.text = "V"
        _vLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_vLabel)
        
        NSLayoutConstraint.activate([
            _vLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            _vLabel.widthAnchor.constraint(equalToConstant: 13)
        ])
    }
    
    private func _setupPaddingSwitch() {
        _paddingSwitch = NSSwitch()
        _paddingSwitch.controlSize = .small
        _paddingSwitch.isOn = CacheManager.shared.paddingEnabled
        _paddingSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_paddingSwitch)
        
        NSLayoutConstraint.activate([
            _paddingSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            _paddingSwitch.centerYAnchor.constraint(equalTo: _titleLabel.centerYAnchor)
        ])
    }
    
    private let _segments: [Int] = [
        16, 32, 64, 96, 128
    ]

    private func _setupSegmentedControls() {
        _hSegmentedControl = NSSegmentedControl()
        _hSegmentedControl.target = self
        _hSegmentedControl.segmentCount = 5
        _hSegmentedControl.segmentDistribution = .fillProportionally
        _hSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        _hSegmentedControl.action = #selector(_segmentedControlValueChanged(_:))
        _hSegmentedControl.selectedSegment = _segments.firstIndex(of: CacheManager.shared.horizontalPadding) ?? 2
        
        addSubview(_hSegmentedControl)
        
        NSLayoutConstraint.activate([
            _hSegmentedControl.topAnchor.constraint(equalTo: _titleLabel.bottomAnchor, constant: 10),
            _hSegmentedControl.leadingAnchor.constraint(equalTo: _hLabel.trailingAnchor, constant: 10),
            _hSegmentedControl.centerYAnchor.constraint(equalTo: _hLabel.centerYAnchor),
            _hSegmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18)
        ])
        
        _vSegmentedControl = NSSegmentedControl()
        _vSegmentedControl.target = self
        _vSegmentedControl.segmentCount = 5
        _vSegmentedControl.selectedSegment = 2
        _vSegmentedControl.segmentDistribution = .fillProportionally
        _vSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        _vSegmentedControl.action = #selector(_segmentedControlValueChanged(_:))
        _vSegmentedControl.selectedSegment = _segments.firstIndex(of: CacheManager.shared.verticalPadding) ?? 2
        
        addSubview(_vSegmentedControl)
        
        NSLayoutConstraint.activate([
            _vSegmentedControl.topAnchor.constraint(equalTo: _hSegmentedControl.bottomAnchor, constant: 12),
            _vSegmentedControl.leadingAnchor.constraint(equalTo: _vLabel.trailingAnchor, constant: 10),
            _vSegmentedControl.centerYAnchor.constraint(equalTo: _vLabel.centerYAnchor),
            _vSegmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18)
        ])
        
        for (index, segment) in _segments.enumerated() {
            _hSegmentedControl.setLabel(String(segment), forSegment: index)
            _vSegmentedControl.setLabel(String(segment), forSegment: index)
        }
    }
    
    @objc private func _segmentedControlValueChanged(_ sender: NSSegmentedControl) {
        if CacheManager.shared.matchedPadding {
            CacheManager.shared.setHorizontalPadding(to: _segments[sender.selectedSegment])
            CacheManager.shared.setVerticalPadding(to: _segments[sender.selectedSegment])
            
            _hSegmentedControl.selectedSegment = sender.selectedSegment
            _vSegmentedControl.selectedSegment = sender.selectedSegment
        } else {
            if sender == _hSegmentedControl {
                CacheManager.shared.setHorizontalPadding(to: _segments[sender.selectedSegment])
            } else if sender == _vSegmentedControl {
                CacheManager.shared.setVerticalPadding(to: _segments[sender.selectedSegment])
            }
        }
        
        CanvasManager.shared.updatePadding()
    }
    
    private func _setupLinkedCheckBox() {
        _linkedCheckBox = NSButton()
        _linkedCheckBox.title = ""
        _linkedCheckBox.setButtonType(.switch)
        _linkedCheckBox.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_linkedCheckBox)
        
        NSLayoutConstraint.activate([
            _linkedCheckBox.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            _linkedCheckBox.centerYAnchor.constraint(equalTo: _hSegmentedControl.bottomAnchor, constant: 6),
            _linkedCheckBox.widthAnchor.constraint(equalToConstant: 15),
            _linkedCheckBox.leadingAnchor.constraint(equalTo: _hSegmentedControl.trailingAnchor, constant: 6),
            _linkedCheckBox.leadingAnchor.constraint(equalTo: _vSegmentedControl.trailingAnchor, constant: 6)
        ])
        
        _linkImageView = NSImageView()
        _linkImageView.image = NSImage(named: "PaddingLink")
        _linkImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_linkImageView)
        
        NSLayoutConstraint.activate([
            _linkImageView.centerYAnchor.constraint(equalTo: _linkedCheckBox.centerYAnchor),
            _linkImageView.centerXAnchor.constraint(equalTo: _linkedCheckBox.centerXAnchor, constant: -0.5)
        ])
    }
    
    private func _setupDividerView() {
        _dividerView = SNSettingsDividerView()
        _dividerView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_dividerView)
        
        NSLayoutConstraint.activate([
            _dividerView.topAnchor.constraint(equalTo: _vSegmentedControl.bottomAnchor, constant: 12),
            _dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            _dividerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        _hSegmentedControl.appearance = .current(in: self)
        _vSegmentedControl.appearance = .current(in: self)
    }
}
