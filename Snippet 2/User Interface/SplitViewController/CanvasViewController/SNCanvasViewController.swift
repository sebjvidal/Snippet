//
//  SNCanvasViewController.swift
//  Snippet
//
//  Created by Seb Vidal on 24/06/2022.
//

import Cocoa

class SNCanvasViewController: NSViewController {
    private var _canvasBackgroundView: SNCanvasBackgroundView!
    private var _canvasView: SNCanvasView!
    
    override func loadView() {
        view = NSView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _setupCanvasViewControllerView()
        _setupCanvasBackgroundView()
        _setupCanvasView()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Test"), object: nil, queue: nil) { _ in
            self.view.layoutSubtreeIfNeeded()
        }
    }
    
    private func _setupCanvasViewControllerView() {
        let visualEffectView = NSVisualEffectView()
        visualEffectView.material = .sidebar
        visualEffectView.blendingMode = .withinWindow
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(visualEffectView)

        NSLayoutConstraint.activate([
            visualEffectView.topAnchor.constraint(equalTo: view.topAnchor),
            visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 500)
        ])
    }
    
    private func _setupCanvasBackgroundView() {
        _canvasBackgroundView = SNCanvasBackgroundView()
        _canvasBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(_canvasBackgroundView)
        
        NSLayoutConstraint.activate([
            _canvasBackgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            _canvasBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            _canvasBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            _canvasBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -18)
        ])
    }
    
    private func _setupCanvasView() {
        _canvasView = SNCanvasView()
        _canvasView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(_canvasView)
        
        NSLayoutConstraint.activate([
            _canvasView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            _canvasView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
}
