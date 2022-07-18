//
//  SNGradientGrip.swift
//  Snippet
//
//  Created by Seb Vidal on 12/07/2022.
//

import Cocoa

class SNGradientGrip: NSView {
    var colour: HSV = HSV(h: 0, s: 0, v: 0) {
        willSet {
            _colourView.layer?.backgroundColor = newValue.cgColor
        }
    }
    
    var delegate: SNGradientGripDelegate?
    
    private var _gripImageView: NSImageView!
    private var _colourView: NSView!
    
    // MARK: Init
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        _setupView()
        _setupGripImageView()
        _setupColourView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _setupView() {
        wantsLayer = true
        layer?.masksToBounds = false
    }
    
    private func _setupGripImageView() {
        _gripImageView = NSImageView(imageNamed: "GradientGrip")
        _gripImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_gripImageView)
        
        NSLayoutConstraint.activate([
            _gripImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            _gripImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func _setupColourView() {
        _colourView = NSView()
        _colourView.wantsLayer = true
        _colourView.layer?.cornerRadius = 2
        _colourView.layer?.cornerCurve = .continuous
        _colourView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_colourView)
        
        NSLayoutConstraint.activate([
            _colourView.leadingAnchor.constraint(equalTo: _gripImageView.leadingAnchor, constant: 3.5),
            _colourView.trailingAnchor.constraint(equalTo: _gripImageView.trailingAnchor, constant: -3.5),
            _colourView.bottomAnchor.constraint(equalTo: _gripImageView.bottomAnchor, constant: -3.5),
            _colourView.heightAnchor.constraint(equalTo: _colourView.widthAnchor)
        ])
    }
}
