//
//  SNBackgroundSettingsGradientTableCellView.swift
//  Snippet
//
//  Created by Seb Vidal on 10/07/2022.
//

import Cocoa

class SNBackgroundSettingsGradientTableCellView: NSTableRowView, SNSettingsTableCellView, NSTextFieldDelegate {
    var height: CGFloat = 306
    
    private var _titleLabel: SNLabel!
    private var _presetButton1: SNButton!
    private var _presetButton2: SNButton!
    private var _presetButton3: SNButton!
    private var _presetButton4: SNButton!
    private var _presetButton5: SNButton!
    private var _presetButton6: SNButton!
    private var _firstDividerView: SNSettingsDividerView!
    private var _customLabel: SNLabel!
    private var _gradientSlider: SNGradientEditor!
    private var _gradientTypeSegmentedControl: NSSegmentedControl!
    private var _gradientSwapColoursButton: NSButton!
    private var _gradientAngleSlider: NSSlider!
    private var _gradientAngleTextField: NSTextField!
    private var _gradientAngleStepper: NSStepper!
    private var _secondDividerView: SNSettingsDividerView!
    
    // MARK: init()
    init() {
        super.init(frame: NSRect.zero)
        _setupTitleLabel()
        _setupPresetButtons()
        _setupFirstDividerView()
        _setupCustomLabel()
        _setupGradientEditor()
        _setupGradientTypeSegmentedControl()
        _setupGradientColourSwapButton()
        _setupGradientAngleSlider()
        _setupGradientAngleTextField()
        _setupGradientAngleStepper()
        _setupSecondDivider()
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
        _presetButton1.selectionGroup = "Gradient"
        _presetButton1.view = .gradient(from: .presets[0])
        _presetButton1.action = {
            self._gradientSlider.gradient = .presets[0]
            CacheManager.shared.setGradient(to: .presets[0])
            CanvasManager.shared.setBackground(to: SNGradient.presets[0])
        }
        _presetButton1.isSelected = CacheManager.shared.gradient.preset == 0
        
        _presetButton2 = SNButton()
        _presetButton2.isSelectable = true
        _presetButton2.selectionGroup = "Gradient"
        _presetButton2.view = .gradient(from: .presets[1])
        _presetButton2.action = {
            self._gradientSlider.gradient = .presets[1]
            CacheManager.shared.setGradient(to: .presets[1])
            CanvasManager.shared.setBackground(to: SNGradient.presets[1])
        }
        _presetButton2.isSelected = CacheManager.shared.gradient.preset == 1
        
        _presetButton3 = SNButton()
        _presetButton3.isSelectable = true
        _presetButton3.selectionGroup = "Gradient"
        _presetButton3.view = .gradient(from: .presets[2])
        _presetButton3.action = {
            
            self._gradientSlider.gradient = .presets[2]
            CacheManager.shared.setGradient(to: .presets[2])
            CanvasManager.shared.setBackground(to: SNGradient.presets[2])
        }
        _presetButton3.isSelected = CacheManager.shared.gradient.preset == 2
        
        _presetButton4 = SNButton()
        _presetButton4.isSelectable = true
        _presetButton4.selectionGroup = "Gradient"
        _presetButton4.view = .gradient(from: .presets[3])
        _presetButton4.action = {
            self._gradientSlider.gradient = .presets[3]
            CacheManager.shared.setGradient(to: .presets[3])
            CanvasManager.shared.setBackground(to: SNGradient.presets[3])
        }
        _presetButton4.isSelected = CacheManager.shared.gradient.preset == 3
        
        _presetButton5 = SNButton()
        _presetButton5.isSelectable = true
        _presetButton5.selectionGroup = "Gradient"
        _presetButton5.view = .gradient(from: .presets[4])
        _presetButton5.action = {
            self._gradientSlider.gradient = .presets[4]
            CacheManager.shared.setGradient(to: .presets[4])
            CanvasManager.shared.setBackground(to: SNGradient.presets[4])
        }
        _presetButton5.isSelected = CacheManager.shared.gradient.preset == 4
        
        _presetButton6 = SNButton()
        _presetButton6.isSelectable = true
        _presetButton6.selectionGroup = "Gradient"
        _presetButton6.view = .gradient(from: .presets[5])
        _presetButton6.action = {
            self._gradientSlider.gradient = .presets[5]
            CacheManager.shared.setGradient(to: .presets[5])
            CanvasManager.shared.setBackground(to: SNGradient.presets[5])
        }
        _presetButton6.isSelected = CacheManager.shared.gradient.preset == 5
        
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
    
    private func _setupGradientEditor() {
        _gradientSlider = SNGradientEditor()
        _gradientSlider.gradient = CacheManager.shared.gradient
        _gradientSlider.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_gradientSlider)
        
        NSLayoutConstraint.activate([
            _gradientSlider.topAnchor.constraint(equalTo: _customLabel.bottomAnchor, constant: 10),
            _gradientSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            _gradientSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18)
        ])
    }
    
    private let _gradientTypes: [CAGradientLayerType] = [
        .axial, .radial, .conic
    ]
    
    private func _setupGradientTypeSegmentedControl() {
        _gradientTypeSegmentedControl = NSSegmentedControl()
        _gradientTypeSegmentedControl.target = self
        _gradientTypeSegmentedControl.segmentCount = 3
        _gradientTypeSegmentedControl.segmentDistribution = .fillEqually
        _gradientTypeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        _gradientTypeSegmentedControl.action = #selector(_gradientTypeSegmentedControlValueChanged)
        _gradientTypeSegmentedControl.selectedSegment = _gradientTypes.firstIndex {
            $0 == CacheManager.shared.gradient.type
        } ?? 0
        
        addSubview(_gradientTypeSegmentedControl)
        
        NSLayoutConstraint.activate([
            _gradientTypeSegmentedControl.topAnchor.constraint(equalTo: _gradientSlider.bottomAnchor, constant: 10),
            _gradientTypeSegmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18)
        ])

        for (index, subview) in _gradientTypeSegmentedControl.subviews.enumerated() {
            let image = index == 0 ? "LinearGradientIcon" : index == 1 ? "RadialGradientIcon" : "ConicalGradientIcon"
            
            let imageView = NSImageView(imageNamed: image)
            imageView.imageScaling = .scaleProportionallyUpOrDown
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            subview.addSubview(imageView)
            
            let offset: CGFloat = index == 0 ? 1 : index == 2 ? -1 : -1
            
            NSLayoutConstraint.activate([
                imageView.centerXAnchor.constraint(equalTo: subview.centerXAnchor, constant: offset),
                imageView.centerYAnchor.constraint(equalTo: subview.centerYAnchor),
                imageView.heightAnchor.constraint(equalToConstant: 13)
            ])
        }
    }
    
    @objc private func _gradientTypeSegmentedControlValueChanged() {
        let type = _gradientTypes[_gradientTypeSegmentedControl.selectedSegment]
        let gradient = CacheManager.shared.gradient
        gradient.type = type
        
        CacheManager.shared.setGradient(to: gradient)
        CanvasManager.shared.setBackground(to: gradient)
    }
    
    private func _setupGradientColourSwapButton() {
        _gradientSwapColoursButton = NSButton()
        _gradientSwapColoursButton.target = self
        _gradientSwapColoursButton.bezelStyle = .regularSquare
        _gradientSwapColoursButton.action = #selector(_colourSwapButtonPressed)
        _gradientSwapColoursButton.translatesAutoresizingMaskIntoConstraints = false
        _gradientSwapColoursButton.image = NSImage(systemSymbolName: "arrow.triangle.2.circlepath")
        
        addSubview(_gradientSwapColoursButton)
        
        NSLayoutConstraint.activate([
            _gradientSwapColoursButton.widthAnchor.constraint(equalToConstant: 35),
            _gradientSwapColoursButton.heightAnchor.constraint(equalToConstant: 21),
            _gradientSwapColoursButton.centerYAnchor.constraint(equalTo: _gradientTypeSegmentedControl.centerYAnchor),
            _gradientSwapColoursButton.leadingAnchor.constraint(equalTo: _gradientTypeSegmentedControl.trailingAnchor, constant: 10)
        ])
    }
    
    @objc private func _colourSwapButtonPressed() {
        let gradient = CacheManager.shared.gradient
        gradient.colours = gradient.colours.reversed()
        
        CacheManager.shared.setGradient(to: gradient)
        CanvasManager.shared.setBackground(to: gradient)
        _gradientSlider.gradient = gradient
    }
    
    private func _setupGradientAngleSlider() {
        _gradientAngleSlider = NSSlider()
        _gradientAngleSlider.minValue = 0
        _gradientAngleSlider.target = self
        _gradientAngleSlider.maxValue = 360
        _gradientAngleSlider.sliderType = .circular
        _gradientAngleSlider.translatesAutoresizingMaskIntoConstraints = false
        _gradientAngleSlider.action = #selector(_gradientAngleSliderValueChanged)
        _gradientAngleSlider.integerValue = Int(CacheManager.shared.gradient.angle)
        
        addSubview(_gradientAngleSlider)
        
        NSLayoutConstraint.activate([
            _gradientAngleSlider.widthAnchor.constraint(equalToConstant: 18),
            _gradientAngleSlider.centerYAnchor.constraint(equalTo: _gradientSwapColoursButton.centerYAnchor),
            _gradientAngleSlider.leadingAnchor.constraint(equalTo: _gradientSwapColoursButton.trailingAnchor, constant: 10)
        ])
    }
    
    @objc private func _gradientAngleSliderValueChanged() {
        let angle = Int(_gradientAngleSlider.floatValue)
        _gradientAngleTextField.integerValue = angle
        _gradientAngleStepper.integerValue = angle
        _updateGradient()
    }
    
    private func _setupGradientAngleTextField() {
        _gradientAngleTextField = NSTextField()
        _gradientAngleTextField.delegate = self
        _gradientAngleTextField.alignment = .center
        _gradientAngleTextField.bezelStyle = .roundedBezel
        _gradientAngleTextField.formatter = SNIntegerNumberFormatter()
        _gradientAngleTextField.translatesAutoresizingMaskIntoConstraints = false
        _gradientAngleTextField.integerValue = Int(CacheManager.shared.gradient.angle)
        
        addSubview(_gradientAngleTextField)
        
        NSLayoutConstraint.activate([
            _gradientAngleTextField.leadingAnchor.constraint(equalTo: _gradientAngleSlider.trailingAnchor, constant: 10),
            _gradientAngleTextField.centerYAnchor.constraint(equalTo: _gradientTypeSegmentedControl.centerYAnchor),
            _gradientAngleTextField.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func controlTextDidEndEditing(_ obj: Notification) {
        if _gradientAngleTextField.stringValue.isEmpty {
            _gradientAngleTextField.integerValue = Int(CacheManager.shared.gradient.angle)
        }
        
        if _gradientAngleTextField.integerValue > 360 {
            _gradientAngleTextField.integerValue = 360
        }
        
        _gradientAngleSlider.integerValue = _gradientAngleTextField.integerValue
        _gradientAngleStepper.integerValue = _gradientAngleTextField.integerValue
        _updateGradient()
    }

    
    private func _setupGradientAngleStepper() {
        _gradientAngleStepper = NSStepper()
        _gradientAngleStepper.minValue = 0
        _gradientAngleStepper.target = self
        _gradientAngleStepper.maxValue = 360
        _gradientAngleStepper.translatesAutoresizingMaskIntoConstraints = false
        _gradientAngleStepper.action = #selector(_gradientAngleStepperValueChanged)
        
        addSubview(_gradientAngleStepper)
        
        NSLayoutConstraint.activate([
            _gradientAngleStepper.centerYAnchor.constraint(equalTo: _gradientAngleTextField.centerYAnchor),
            _gradientAngleStepper.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            _gradientAngleStepper.leadingAnchor.constraint(equalTo: _gradientAngleTextField.trailingAnchor, constant: 2)
        ])
    }
    
    @objc private func _gradientAngleStepperValueChanged() {
        _gradientAngleSlider.integerValue = _gradientAngleStepper.integerValue
        _gradientAngleTextField.integerValue = _gradientAngleStepper.integerValue
    }
    
    private func _updateGradient() {
        let angle = _gradientAngleSlider.floatValue
        let gradient = CacheManager.shared.gradient
        gradient.angle = angle.cgFloat

        CacheManager.shared.setBackground(to: gradient)
        CanvasManager.shared.setBackground(to: gradient)
    }
    
    private func _setupSecondDivider() {
        _secondDividerView = SNSettingsDividerView()
        _secondDividerView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_secondDividerView)
        
        NSLayoutConstraint.activate([
            _secondDividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            _secondDividerView.topAnchor.constraint(equalTo: _gradientTypeSegmentedControl.bottomAnchor, constant: 12),
            _secondDividerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    // MARK: layout()
    override func layout() {
        super.layout()
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
    
    // MARK: draw(_:)
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        let appearance = NSAppearance.current(in: self)
        _gradientTypeSegmentedControl.appearance = appearance
        _gradientSwapColoursButton.appearance = appearance
        _gradientAngleSlider.appearance = appearance
        _gradientAngleTextField.appearance = appearance
        _gradientAngleStepper.appearance = appearance
    }
}

