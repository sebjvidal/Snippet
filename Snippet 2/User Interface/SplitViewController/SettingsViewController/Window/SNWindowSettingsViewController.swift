//
//  SNWindowSettingsViewController.swift
//  Snippet
//
//  Created by Seb Vidal on 01/07/2022.
//

import Cocoa

class SNWindowSettingsViewController: SNTableViewController, NSTableViewDelegate, NSTableViewDataSource {
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        _setupTableView()
    }
    
    /// Setup tableView
    private func _setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private var _cells: [SNSettingsTableCellView] = [
        SNSettingsTableCellViewHeader(named: "Window"),
        SNWindowSettingsTitleTableCellView(),
        SNWindowSettingsControlsTableCellView(),
        SNWindowSettingsAppearanceTableCellView(),
        SNWindowSettingsOpacityTableCellView(),
        SNWindowSettingsPaddingTableCellView()
    ]
    
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
