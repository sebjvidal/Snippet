//
//  SNBackgroundSettingsImageTableCellView.swift
//  Snippet
//
//  Created by Seb Vidal on 14/07/2022.
//

import Cocoa
import Kingfisher

class SNBackgroundSettingsImageTableCellView: NSTableRowView, SNSettingsTableCellView, URLSessionDelegate {
    var height: CGFloat = 600
    
    private var _titleLabel: SNLabel!
    private var _imageView: NSImageView!
    private var _presetButton1: SNButton!
    private var _presetButton2: SNButton!
    private var _presetButton3: SNButton!
    private var _presetButton4: SNButton!
    private var _presetButton5: SNButton!
    private var _presetButton6: SNButton!
    private var _presetButton7: SNButton!
    private var _presetButton8: SNButton!
    private var _presetButton9: SNButton!
    private var _presetButton10: SNButton!
    private var _presetButton11: SNButton!
    private var _presetButton12: SNButton!
    private var _presetButton13: SNButton!
    private var _dividerView: SNSettingsDividerView!
    
    init() {
        super.init(frame: NSRect.zero)
        _setupTitleLabel()
        _setupPresetButtons()
        _setupDividerView()
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
    
    let test = SNImageView()
    
    private func _setupPresetButtons() {
        _presetButton1 = SNButton()
        _presetButton1.isSelectable = true
        _presetButton1.view = .image(from: .presets[0])
        _presetButton1.action = { [unowned self] in
            _download(preset: .presets[0], sender: _presetButton1)
        }
        
        _presetButton2 = SNButton()
        _presetButton2.isSelectable = true
        _presetButton2.view = .image(from: .presets[1])
        _presetButton2.action = { [unowned self] in
            _download(preset: .presets[1], sender: _presetButton2)
        }
        
        _presetButton3 = SNButton()
        _presetButton3.isSelectable = true
        _presetButton3.view = .image(from: .presets[2])
        _presetButton3.action = { [unowned self] in
            _download(preset: .presets[2], sender: _presetButton3)
        }
        
        _presetButton4 = SNButton()
        _presetButton4.isSelectable = true
        _presetButton4.view = .image(from: .presets[3])
        _presetButton4.action = { [unowned self] in
            _download(preset: .presets[3], sender: _presetButton4)
        }
        
        _presetButton5 = SNButton()
        _presetButton5.isSelectable = true
        _presetButton5.view = .image(from: .presets[4])
        _presetButton5.action = { [unowned self] in
            _download(preset: .presets[4], sender: _presetButton5)
        }
        
        _presetButton6 = SNButton()
        _presetButton6.isSelectable = true
        _presetButton6.view = .image(from: .presets[5])
        _presetButton6.action = { [unowned self] in
            _download(preset: .presets[5], sender: _presetButton6)
        }
        
        _presetButton7 = SNButton()
        _presetButton7.isSelectable = true
        _presetButton7.view = .image(from: .presets[6])
        _presetButton7.action = { [unowned self] in
            _download(preset: .presets[6], sender: _presetButton7)
        }
        
        _presetButton8 = SNButton()
        _presetButton8.isSelectable = true
        _presetButton8.view = .image(from: .presets[7])
        _presetButton8.action = { [unowned self] in
            _download(preset: .presets[7], sender: _presetButton8)
        }
        _presetButton8.accessoryImage = NSImage(named: "LightDarkIcon")
        
        _presetButton9 = SNButton()
        _presetButton9.isSelectable = true
        _presetButton9.view = .image(from: .presets[8])
        _presetButton9.action = { [unowned self] in
            _download(preset: .presets[8], sender: _presetButton9)
        }
        _presetButton9.accessoryImage = NSImage(named: "LightDarkIcon")
        
        _presetButton10 = SNButton()
        _presetButton10.isSelectable = true
        _presetButton10.view = .image(from: .presets[9])
        _presetButton10.action = { [unowned self] in
            _download(preset: .presets[9], sender: _presetButton10)
        }
        _presetButton10.accessoryImage = NSImage(named: "LightDarkIcon")
        
        _presetButton11 = SNButton()
        _presetButton11.isSelectable = true
        _presetButton11.view = .image(from: .presets[10])
        _presetButton11.action = { [unowned self] in
            _download(preset: .presets[10], sender: _presetButton11)
        }
        _presetButton11.accessoryImage = NSImage(named: "LightDarkIcon")
        
        _presetButton12 = SNButton()
        _presetButton12.isSelectable = true
        _presetButton12.view = .image(from: .presets[11])
        _presetButton12.action = { [unowned self] in
            _download(preset: .presets[11], sender: _presetButton12)
        }
        _presetButton12.accessoryImage = NSImage(named: "LightDarkIcon")
        
        _presetButton13 = SNButton()
        _presetButton13.isSelectable = true
        _presetButton13.view = .image(from: .presets[12])
        _presetButton13.action = { [unowned self] in
            _download(preset: .presets[12], sender: _presetButton13)
        }
        _presetButton13.accessoryImage = NSImage(named: "LightDarkIcon")
        
        addSubview(_presetButton1)
        addSubview(_presetButton2)
        addSubview(_presetButton3)
        addSubview(_presetButton4)
        addSubview(_presetButton5)
        addSubview(_presetButton6)
        addSubview(_presetButton7)
        addSubview(_presetButton8)
        addSubview(_presetButton9)
        addSubview(_presetButton10)
        addSubview(_presetButton11)
        addSubview(_presetButton12)
        addSubview(_presetButton13)
        
        test.layer?.masksToBounds = true
        test.imageScaling = .scaleProportionallyUpOrDown
        test.invalidateIntrinsicContentSize()
        test.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(test)
        
        NSLayoutConstraint.activate([
            test.topAnchor.constraint(equalTo: _presetButton13.bottomAnchor, constant: 10),
            test.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            test.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            test.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func _download(preset: SNImage, sender: SNButton) {
        sender.isLoading = true
        
        var estimatedSize: Int64 = 0
        var receivedSizeLight: Int64 = 0
        var receivedSizeDark: Int64 = 0
        
        KingfisherManager.shared.retrieveImage(with: ImageResource(downloadURL: preset.path.first!), progressBlock: { receivedSize, totalSize in
            estimatedSize = totalSize * Int64((preset.path.count))
            receivedSizeLight = receivedSize
            
            let value = (Double(receivedSizeLight + receivedSizeDark) / Double(estimatedSize)) * 100
            sender.loadingValue = value
        }, completionHandler: { result in
            KingfisherManager.shared.retrieveImage(with: ImageResource(downloadURL: preset.path.last!), progressBlock: { receivedSize, totalSize in
                receivedSizeDark = receivedSize
                
                let value = (Double(receivedSizeLight + receivedSizeDark) / Double(estimatedSize)) * 100
                sender.loadingValue = value
            }, completionHandler: { result in
                sender.loadingValue = 100
                self._loadCached(preset: preset, sender: sender)
            })
        })
    }
    
    private func _loadCached(preset: SNImage, sender: SNButton) {
        ImageCache.default.retrieveImage(forKey: preset.path.first!.absoluteString) { lightResult in
            ImageCache.default.retrieveImage(forKey: preset.path.last!.absoluteString) { darkResult in
                do {
                    let light = try lightResult.get().image!
                    let dark = try darkResult.get().image!
                    let dynamic = SNDynamicImage(light: light, dark: dark)
                    self.test.dynamicImage = dynamic
                } catch {
                    
                }
            }
        }
    }
    
    private func _setupDividerView() {
//        _dividerView = SNSettingsDividerView()
//        _dividerView.translatesAutoresizingMaskIntoConstraints = false
//
//        addSubview(_dividerView)
//
//        NSLayoutConstraint.activate([
//            _dividerView.topAnchor.constraint(equalTo: _backgroundComboBox.bottomAnchor, constant: 12),
//            _dividerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
//            _dividerView.trailingAnchor.constraint(equalTo: trailingAnchor)
//        ])
    }
    
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
        
        let y3: CGFloat = _presetButton4.frame.maxY + 10.0
        _presetButton7.frame = CGRect(x: 18, y: y3, width: width, height: 60)
        _presetButton8.frame = CGRect(x: _presetButton1.frame.maxX + 10, y: y3, width: width, height: 60)
        _presetButton9.frame = CGRect(x: _presetButton2.frame.maxX + 10, y: y3, width: width, height: 60)
        
        let y4: CGFloat = _presetButton7.frame.maxY + 10.0
        _presetButton10.frame = CGRect(x: 18, y: y4, width: width, height: 60)
        _presetButton11.frame = CGRect(x: _presetButton1.frame.maxX + 10, y: y4, width: width, height: 60)
        _presetButton12.frame = CGRect(x: _presetButton2.frame.maxX + 10, y: y4, width: width, height: 60)
        
        let y5: CGFloat = _presetButton10.frame.maxY + 10.0
        _presetButton13.frame = CGRect(x: 18, y: y5, width: width, height: 60)
    }
}

class SNDynamicImage {
    private(set) var light: NSImage
    private(set) var dark: NSImage
    
    init(light: NSImage, dark: NSImage) {
        self.light = light
        self.dark = dark
    }
}
