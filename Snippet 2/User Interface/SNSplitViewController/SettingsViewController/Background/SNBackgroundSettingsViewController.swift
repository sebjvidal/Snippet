//
//  SNBackgroundSettingsViewController.swift
//  Snippet
//
//  Created by Seb Vidal on 01/07/2022.
//

import Cocoa

class SNBackgroundSettingsViewController: SNTableViewController, NSTableViewDelegate, NSTableViewDataSource {
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        _setupTableView()
        _addBackgroundTypeCell()
        _addBackgroundAccessoryCell()
        tableView.reloadData()
    }
    
    /// Setup tableView
    private func _setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private var _cells: [SNSettingsTableCellView] = [
        SNSettingsTableCellViewHeader(named: "Background")
    ]
    
    private let _accessoryCells: [String: SNSettingsTableCellView] = [
        "Solid Colour": SNBackgroundSettingsSolidColourTableCellView(),
        "Gradient": SNBackgroundSettingsGradientTableCellView(),
        "Image": SNBackgroundSettingsImageTableCellView()
    ]
    
    private func _addBackgroundTypeCell() {
        let cell = SNBackgroundSettingsBackgroundTableCellView(parent: self)
        _cells.append(cell)
    }
    
    private func _addBackgroundAccessoryCell() {
        if let cell = _accessoryCells[CacheManager.shared.backgroundType.rawValue] {
            _cells.append(cell)
        }
    }
    
    func setAccessoryCell(to type: SNBackgroundType) {
        if let cell = _accessoryCells[type.rawValue] {
            _cells[2] = cell
        }
        
        NSAnimationContext().duration = 0
        tableView.reloadData(forRowIndexes: [1, 2], columnIndexes: [0])
        tableView.noteHeightOfRows(withIndexesChanged: [2])
    }
    
    // MARK: NumberOfRowsInTableView
    func numberOfRows(in tableView: NSTableView) -> Int {
        return _cells.count
    }
    
    // MARK: ViewForTableColumns
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        return _cells[row]
    }
    
    // MARK: HeightOfRow
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return _cells[row].height
    }
    
    // MARK: ShouldSelectRow
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return false
    }
}
