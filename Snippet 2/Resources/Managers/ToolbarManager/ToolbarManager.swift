//
//  ToolbarManager.swift
//  Snippet
//
//  Created by Seb Vidal on 28/06/2022.
//

import Cocoa

class ToolbarManager: NSObject, NSToolbarDelegate {
    static let shared = ToolbarManager()
    
    private var _window: NSWindow!
    private var _splitView: NSSplitViewController!
    private var _selection = 0
    
    var toolbar: NSToolbar!
    
    // MARK: Init
    override private init() {
        _window = NSApp.windows.first
        _splitView = _window.contentViewController as? NSSplitViewController
    }
    
    func setupToolbar() {
        toolbar = NSToolbar()
        toolbar.delegate = self
        toolbar.displayMode = .iconOnly
        toolbar.showsBaselineSeparator = true
        
        _window.title = "Snippet"
        _window.subtitle = "Untitled"
        _window.toolbar = toolbar
        _window.toolbarStyle = .unified
        _window.titleVisibility = .hidden
        _window.titlebarAppearsTransparent = true
        _window.titlebarSeparatorStyle = .shadow
    }
    
    // MARK: NSToolbarDelegate
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [
            NSToolbarItem.Identifier("LeadingSeparator"),
            NSToolbarItem.Identifier("PresetGroup"),
            NSToolbarItem.Identifier("PresetMenu"),
            NSToolbarItem.Identifier.flexibleSpace,
            NSToolbarItem.Identifier("Share"),
            NSToolbarItem.Identifier("Sidebar"),
            NSToolbarItem.Identifier("TrailingSeparator"),
            NSToolbarItem.Identifier.flexibleSpace,
            NSToolbarItem.Identifier("TabGroup"),
            NSToolbarItem.Identifier.flexibleSpace
        ]
    }
    
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return toolbarDefaultItemIdentifiers(toolbar)
    }
    
    func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        switch itemIdentifier {
        case NSToolbarItem.Identifier("LeadingSeparator"):
            let item = NSTrackingSeparatorToolbarItem(
                identifier: itemIdentifier,
                splitView: _splitView.splitView,
                dividerIndex: 0
            )
            
            return item
        case NSToolbarItem.Identifier("PresetGroup"):
            let titles = ["Default", "Mojave Light"] // PresetManager.shared.presetNames
            let selection = 0 // titles.firstIndex(of: PresetManager.shared.selectedPresetName) ?? 0
            let toolbarItem = NSToolbarItemGroup(itemIdentifier: itemIdentifier, titles: titles, selectionMode: .selectOne, labels: titles, target: self, action: #selector(_tabTapped(_:)))
            toolbarItem.toolTip = "Presets"
            toolbarItem.selectedIndex = selection
            toolbarItem.controlRepresentation = .collapsed
            
            return toolbarItem
            
        case NSToolbarItem.Identifier("PresetMenu"):
            let newItem = NSMenuItem(title: "New Preset", action: nil, keyEquivalent: "")
            newItem.image = NSImage(systemSymbolName: "plus")
            
            let editItem = NSMenuItem(title: "Edit Preset Name", action: nil, keyEquivalent: "")
            editItem.image = NSImage(systemSymbolName: "pencil")
            
            let deleteItem = NSMenuItem(title: "Delete Preset", action: nil, keyEquivalent: "")
            deleteItem.image = NSImage(systemSymbolName: "trash")
            
            let menu = NSMenu()
            menu.items = [newItem, editItem, .separator(), deleteItem]
            
            let item = NSMenuToolbarItem(itemIdentifier: itemIdentifier)
            item.image = NSImage(systemSymbolName: "ellipsis.circle")
            item.toolTip = "More"
            item.menu = menu
            
            return item
        case NSToolbarItem.Identifier("Share"):
            let item = NSToolbarItem(itemIdentifier: itemIdentifier)
            item.image = NSImage(systemSymbolName: "square.and.arrow.up")
            item.isBordered = true
            item.toolTip = "Share"
            item.target = self
            item.action = #selector(_nop)
            
            return item
        case NSToolbarItem.Identifier("Sidebar"):
            let item = NSToolbarItem(itemIdentifier: itemIdentifier)
            item.target = self
            item.isBordered = true
            item.toolTip = "Show Sidebar"
            item.action = #selector(_toggleSidebar)
            item.image = NSImage(systemSymbolName: "sidebar.right")
            
            return item
        case NSToolbarItem.Identifier("TrailingSeparator"):
            let item = NSTrackingSeparatorToolbarItem(
                identifier: itemIdentifier,
                splitView: _splitView.splitView,
                dividerIndex: 1
            )
            
            return item
        case NSToolbarItem.Identifier("TabGroup"):
            let images = [
                NSImage(systemSymbolName: "macwindow")!,
                NSImage(systemSymbolName: "text.alignleft")!,
                NSImage(systemSymbolName: "square.2.stack.3d")!,
                NSImage(systemSymbolName: "rectangle.3.group")!,
                NSImage(systemSymbolName: "checkmark.seal")!
            ]
            
            let group = NSToolbarItemGroup(itemIdentifier: itemIdentifier, images: images, selectionMode: .selectOne, labels: [], target: self, action: #selector(_tabTapped(_:)))
            group.setSelected(true, at: _selection)
            group.subitems[0].toolTip = "Window"
            group.subitems[1].toolTip = "Editor"
            group.subitems[2].toolTip = "Background"
            group.subitems[3].toolTip = "Canvas Size"
            group.subitems[4].toolTip = "Watermark"
            
            return group
        default:
            break
        }
        
        return NSToolbarItem(itemIdentifier: itemIdentifier)
    }
    
    @objc private func _nop() {
        // No Operation
    }
    
    @objc private func _toggleSidebar() {
        if let settings = _splitView.splitViewItems.last {
            if !settings.isCollapsed {
                removeTabItems()
            } else {
                insertTabItems()
            }
            
            settings.animator().isCollapsed.toggle()
        }
    }
    
    // MARK: Remove/Insert Tab Items
    
    private var _processing = false
    private var _settingsViewController: SNSettingsViewController? {
        return _splitView.splitViewItems.last?.viewController as? SNSettingsViewController
    }
    
    func removeTabItems(withDelay delay: Double = 0.2) {
        if _processing { return }
        _processing = true
        
        defer { _processing = false }
        
        guard toolbar.items.indices.contains(8) else {
            return
        }
        
        toolbar?.removeItem(at: 9)
        toolbar?.removeItem(at: 8)
        toolbar?.removeItem(at: 7)
        
        _settingsViewController?.toggleToolbarPlaceholderView(on: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [unowned self] in
            _settingsViewController?.toggleToolbarPlaceholderView(on: false)
            toolbar?.removeItem(at: 6)
        }
    }
    
    func insertTabItems(withDelay delay: Double = 0.25) {
        if _processing { return }
        _processing = true
        
        defer { _processing = false }
        
        guard let toolbar = toolbar, !toolbar.items.indices.contains(6) else {
            return
        }
        
        toolbar.insertItem(withItemIdentifier: NSToolbarItem.Identifier("TrailingSeparator"), at: 6)
        
        _settingsViewController?.toggleToolbarPlaceholderView(on: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [unowned self] in
            _settingsViewController?.toggleToolbarPlaceholderView(on: false)
            
            toolbar.insertItem(withItemIdentifier: NSToolbarItem.Identifier.flexibleSpace, at: 7)
            toolbar.insertItem(withItemIdentifier: NSToolbarItem.Identifier("TabGroup"), at: 8)
            toolbar.insertItem(withItemIdentifier: NSToolbarItem.Identifier.flexibleSpace, at: 9)
        }
    }
    
    @objc private func _tabTapped(_ sender: NSToolbarItemGroup) {
        _selection = sender.selectedIndex
        _settingsViewController?.switchTab(to: sender.selectedIndex)
    }
}
