//
//  SNButton.swift
//  Snippet
//
//  Created by Seb Vidal on 06/07/2022.
//

import AppKit
import SwiftUI

class SNButton: NSView, ObservableObject {
    private var _snButton: _SNButton!
    private var _snButtonView: NSView!
    private var _progressIndicator: NSProgressIndicator!
    private var _label: SNLabel!
    
    @Published var accessoryImage: NSImage? = nil
    
    var action: (() -> Void)? = nil
    
    var cornerRadius: CGFloat = 6 {
        willSet {
            layer?.cornerRadius = newValue
            _snButtonView.layer?.cornerRadius = newValue + 1
        }
    }

    var label: String = "" {
        willSet {
            _label.text = newValue
        }
    }

    @Published var isLoading: Bool = false {
        didSet {
            if isLoading {
                _progressIndicator.doubleValue = 0
                _progressIndicator.alphaValue = 1
            }
        }
    }
    
    var isSelected: Bool = false {
        didSet {
            _updateButton()
        }
    }
    
    var loadingValue: Double = 0 {
        didSet {
            _progressIndicator.doubleValue = loadingValue
            
            if loadingValue == 100 {
                NSAnimationContext.runAnimationGroupAfter(deadline: .now() + 0.5) { context in
                    context.duration = 0.5
                    self._progressIndicator.animator().alphaValue = 0
                    self.isLoading = false
                }
            }
        }
    }
    
    var isSelectable: Bool = false
    
    @Published var view: AnyView = .emptyView

    // MARK: Init
    init() {
        super.init(frame: .zero)
        wantsLayer = true
        layer?.cornerRadius = 5
        layer?.masksToBounds = false
        layer?.cornerCurve = .continuous
        
        _setupHostingView()
        _setupProgressIndicator()
        _setupLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func _setupHostingView() {
        _snButton = _SNButton(snButton: self)

        let hostingController = NSHostingController(rootView: _snButton)
        _snButtonView = hostingController.view
        _snButtonView.layer?.masksToBounds = true
        _snButtonView.layer?.cornerCurve = .continuous
        _snButtonView.layer?.cornerRadius = 6
        _snButtonView.autoresizingMask = [.height, .width]

        addSubview(_snButtonView)
    }
    
    private func _setupProgressIndicator() {
        _progressIndicator = NSProgressIndicator()
        _progressIndicator.isIndeterminate = false
        _progressIndicator.controlSize = .regular
        _progressIndicator.style = .spinning
        _progressIndicator.alphaValue = 0
        _progressIndicator.maxValue = 100
        _progressIndicator.minValue = 0
        _progressIndicator.controlTint = .blueControlTint
        _progressIndicator.translatesAutoresizingMaskIntoConstraints = false
        _progressIndicator.appearance = .current(in: self)
        
        addSubview(_progressIndicator)
        
        NSLayoutConstraint.activate([
            _progressIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            _progressIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func _setupLabel() {
        _label = SNLabel()
        _label.translatesAutoresizingMaskIntoConstraints = false

        addSubview(_label)

        NSLayoutConstraint.activate([
            _label.centerXAnchor.constraint(equalTo: centerXAnchor),
            _label.topAnchor.constraint(equalTo: bottomAnchor, constant: 8)
        ])
    }
    
    @Published fileprivate var _frame = CGRect()
    
    override func layout() {
        super.layout()
        _frame = frame
    }

    // MARK: Draw
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        _updateButton()
    }

    private func _updateButton() {
        layer?.borderWidth = isSelected && isSelectable ? 2 : 1
        layer?.borderColor = isSelected && isSelectable ? NSColor.controlAccentColor.cgColor : NSColor(named: "GradientButtonBorder")?.cgColor
    }

    fileprivate func _invalidateOthers() {
        for subview in superview!.subviews {
            if let subview = subview as? SNButton {
                if NSAppearance.current(in: self).isLight {
                    NSAppearance().performAsCurrentDrawingAppearance {
                        subview.isSelected = false
                    }
                } else {
                    subview.isSelected = false
                }
            }
        }
    }
}

private struct _SNButton: View {
    @StateObject var snButton: SNButton

    // MARK: Body
    var body: some View {
        ZStack {
            Button(action: _action) {
                snButton.view
            }
            .buttonStyle(.snButton)
            
            if let image = snButton.accessoryImage {
                Image(nsImage: image)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .frame(width: 12, height: 12)
                    .padding(6)
                    .frame(width: snButton._frame.width, height: snButton._frame.height, alignment: .bottomTrailing)
            }
            
            Color.black
                .opacity(snButton.isLoading ? 0.5 : 0)
                .animation(animation, value: snButton.isLoading)
        }
    }

    private func _action() {
        if snButton.isSelectable {
            snButton._invalidateOthers()
            snButton.isSelected = true
        }
        
        if let action = snButton.action {
            action()
        }
    }
    
    var animation: Animation? {
        if snButton.isLoading {
            return nil
        } else {
            return Animation.easeInOut(duration: 0.5)
        }
    }
}
