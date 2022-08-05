//
//  SNCanvasViewController.swift
//  Snippet
//
//  Created by Seb Vidal on 24/06/2022.
//

import Cocoa
import SwiftUI

class SNCanvasViewController: NSViewController {
    private var _backgroundView: NSView!
    private var _containerView: NSView!
    
    var scrollView: NSScrollView!
    var canvasView: SNCanvasView!
    
    // MARK: loadView()
    override func loadView() {
        view = NSView()
    }
    
    // MARK: viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        _setupCanvasViewControllerView()
        _setupBackgroundView()
        _setupContainerView()
        _setupCanvasView()
        _setupScrollView()
    }
    
    private func _setupCanvasViewControllerView() {
        let visualEffectView = NSVisualEffectView()
        visualEffectView.material = .sidebar
        visualEffectView.blendingMode = .behindWindow
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
    
    private func _setupBackgroundView() {
        _backgroundView = SNCanvasBackgroundView()
        _backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(_backgroundView)
        
        NSLayoutConstraint.activate([
            _backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            _backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            _backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            _backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -18)
        ])
    }
    
    private func _setupContainerView() {
        _containerView = NSView()
    }
    
    private func _setupCanvasView() {
        canvasView = SNCanvasView()
        canvasView.parent = self
        
        _containerView.addSubview(canvasView)
    }
    
    private func _setupScrollView() {
        scrollView = SNCanvasScrollView()
        scrollView.drawsBackground = false
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = true
        scrollView.documentView = _containerView
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -18)
        ])
    }
    
    // MARK: viewDidLayout()
    override func viewDidLayout() {
        super.viewDidLayout()
        if CacheManager.shared.aspectRatio.name == .fill {
            canvasView.perform(Selector(("_fillLayout")))
        }
        
        _layoutCanvas()
        _layoutContainerView()
    }
    
    func _layoutCanvas() {
        let width = canvasView.intrinsicContentSize.width
        let height = canvasView.intrinsicContentSize.height
        canvasView.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }
    
    private func _layoutContainerView() {
        let canvasWidth = canvasView.frame.width
        let canvasHeight = canvasView.frame.height
        
        let scrollWidth = scrollView.frame.width
        let scrollHeight = scrollView.frame.height
        
        let width = canvasWidth < scrollWidth ? scrollWidth : canvasWidth
        let height = canvasHeight < scrollHeight ? scrollHeight : canvasHeight
        _containerView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        let midX = (scrollWidth / 2) - (canvasWidth / 2)
        let midY = (scrollHeight / 2) - (canvasHeight / 2)
        canvasView.frame = CGRect(
            x: canvasWidth < scrollWidth ? midX : 0,
            y: canvasHeight < scrollHeight ? midY : 0,
            width: canvasWidth, height: canvasHeight
        )
    }
}
