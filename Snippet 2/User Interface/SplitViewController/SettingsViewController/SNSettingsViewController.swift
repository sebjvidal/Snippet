//
//  SNSettingsViewController.swift
//  Snippet
//
//  Created by Seb Vidal on 27/06/2022.
//

import Cocoa

class SNSettingsViewController: NSViewController {
    private var _toolbarPlaceholderView: NSStackView!
    private var _tabView: NSTabView!
    
    // MARK: LoadView
    override func loadView() {
        view = SNSettingsBackgroundView()
        view.wantsLayer = true
    }

    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        _setupSettingsView()
        _setupToolbarPlaceholderView()
        _setupSettingsDividerView()
        _setupSettingsTabView()
    }
    
    /// Initial SettingsView setup
    private func _setupSettingsView() {
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 300)
        ])
    }
    
    /// Setup toolbarPlaceholderView
    private func _setupToolbarPlaceholderView() {
        _toolbarPlaceholderView = NSStackView()
        _toolbarPlaceholderView.spacing = 0
        _toolbarPlaceholderView.alignment = .centerY
        _toolbarPlaceholderView.orientation = .horizontal
        _toolbarPlaceholderView.translatesAutoresizingMaskIntoConstraints = false
        _toolbarPlaceholderView.alphaValue = 0
        
        view.addSubview(_toolbarPlaceholderView)
        
        NSLayoutConstraint.activate([
            _toolbarPlaceholderView.topAnchor.constraint(equalTo: view.topAnchor, constant: -0.5),
            _toolbarPlaceholderView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -0.5),
            _toolbarPlaceholderView.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        let symbols = [
            "macwindow", "text.alignleft", "square.2.stack.3d", "rectangle.3.group", "checkmark.seal"
        ]
        
        for (index, symbol) in symbols.enumerated() {
            let config = NSImage.SymbolConfiguration(scale: .large)
            let image = NSImage(systemSymbolName: symbol)!.withSymbolConfiguration(config)
            
            let imageView = NSImageView(image: image!)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.layer?.backgroundColor = NSColor.systemOrange.cgColor
            imageView.contentTintColor = NSColor(named: "ToolbarItemTint")
            
            _toolbarPlaceholderView.addArrangedSubview(imageView)
            
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: [0, 4].contains(index) ? 34 : 40)
            ])
            
            if index != symbols.count - 1 {
                let separator = SNSettingsToolbarSeparatorView()
                separator.translatesAutoresizingMaskIntoConstraints = false
                
                _toolbarPlaceholderView.addArrangedSubview(separator)
                
                NSLayoutConstraint.activate([
                    separator.widthAnchor.constraint(equalToConstant: 1),
                    separator.heightAnchor.constraint(equalToConstant: 20)
                ])
            }
        }
    }
    
    /// Public func to toggle toolbarPlaceholderView
    func toggleToolbarPlaceholderView(on: Bool) {
        _toolbarPlaceholderView.alphaValue = on ? 1 : 0
    }
    
    /// Setup divider between toolbarPlaceholderView and tabView
    private func _setupSettingsDividerView() {
        let divider = SNSettingsDividerView()
        divider.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(divider)
        
        NSLayoutConstraint.activate([
            divider.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -1),
            divider.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    /// Initial tabView setup
    private func _setupSettingsTabView() {
        _tabView = NSTabView()
        _tabView.tabViewType = .noTabsNoBorder
        _tabView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(_tabView)
        
        NSLayoutConstraint.activate([
            _tabView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            _tabView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            _tabView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            _tabView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let tabViewItems = [
            NSTabViewItem(viewController: SNWindowSettingsViewController()),
            NSTabViewItem(viewController: SNEditorSettingsViewController()),
            NSTabViewItem(viewController: SNBackgroundSettingsViewController()),
            NSTabViewItem(viewController: SNSizeSettingsViewController()),
            NSTabViewItem(viewController: SNWatermarkSettingsViewController())
        ]
        
        for (index, item) in tabViewItems.enumerated() {
            _tabView.insertTabViewItem(item, at: index)
        }
    }
    
    /// Public func to switch tabView tab
    func switchTab(to index: Int) {
        if _tabView.tabViewItems.indices.contains(index) {
            _tabView.selectTabViewItem(at: index)
        }
    }
}
