//
//  SNGradientEditor.swift
//  Snippet
//
//  Created by Seb Vidal on 10/07/2022.
//

import Cocoa

class SNGradientEditor: NSView {
    var gradient: SNGradient = .presets[1] {
        didSet {
            _updateGradientLayer()
            _updateGradientGrips()
        }
    }
    
    private var _gradientView: NSView!
    private var _gradientLayer: CAGradientLayer!
    private var _gradientGrips: [SNGradientGrip] = []
    
    init() {
        super.init(frame: .zero)
        _setupGradientView()
        _setupGradientLayer()
        wantsLayer = true
        layer?.masksToBounds = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _setupGradientView() {
        _gradientView = NSView()
        _gradientView.wantsLayer = true
        _gradientView.layer?.borderWidth = 1
        _gradientView.layer?.cornerRadius = 5
        _gradientView.layer?.masksToBounds = true
        _gradientView.layer?.cornerCurve = .continuous
        _gradientView.layer?.borderColor = NSColor(named: "CanvasBorder")?.cgColor
        _gradientView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_gradientView)
        
        NSLayoutConstraint.activate([
            _gradientView.topAnchor.constraint(equalTo: topAnchor),
            _gradientView.heightAnchor.constraint(equalToConstant: 30),
            _gradientView.leadingAnchor.constraint(equalTo: leadingAnchor),
            _gradientView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func _setupGradientLayer() {
        _gradientLayer = CAGradientLayer()
        _gradientLayer.locations = [0, 1]
        _gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        _gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        _gradientLayer.autoresizingMask = [.layerWidthSizable, .layerHeightSizable]
        
        _gradientView.layer?.addSublayer(_gradientLayer)
    }
    
    private func _updateGradientLayer() {
        _gradientLayer.colors = gradient.colours.map { $0.cgColor }
    }
    
    private func _updateGradientGrips() {
        for grip in _gradientGrips {
            grip.removeFromSuperview()
        }
        
        _gradientGrips.removeAll()
        
        for (colour, location) in zip(gradient.colours, gradient.locations) {
            let grip = SNGradientGrip()
            grip.colour = colour
            
            addSubview(grip)
            _gradientGrips.append(grip)
        }
    }
    
    // MARK: IntrinsicContentSize
    override var intrinsicContentSize: NSSize {
        return NSSize(width: .zero, height: 44)
    }
    
    override func layout() {
        super.layout()
        
        for (grip, location) in zip(_gradientGrips, gradient.locations) {
            let x = CGFloat(truncating: location)
            grip.frame = CGRect(x: ((_gradientView.frame.width - 3) * x) - 7, y: 0, width: 16, height: 22)
        }
    }
    
    // MARK: Draw
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        _gradientView.layer?.borderColor = NSColor(named: "CanvasBorder")?.cgColor
    }
}
