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
    
    private let _accessoryCells: [SNSettingsTableCellView] = [
        SNBackgroundSettingsSolidColourTableCellView(),
        SNBackgroundSettingsGradientTableCellView(),
        SNBackgroundSettingsImageTableCellView()
    ]
    
    private func _addBackgroundTypeCell() {
        let cell = SNBackgroundSettingsBackgroundTableCellView(parent: self)
        _cells.append(cell)
    }
    
    private func _addBackgroundAccessoryCell() {
        let cell = _accessoryCells[0]
        _cells.append(cell)
    }
    
    func setAccessoryCellIndex(to index: Int) {
        let cell = _accessoryCells[index]
        _cells[2] = cell
        
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
        return true
    }
}
