//
//  SNTableViewController.swift
//  Snippet
//
//  Created by Seb Vidal on 05/07/2022.
//

import Cocoa

class SNTableViewController: NSViewController {
    var tableView = NSTableView()
    var scrollView = SNScrollView()
    
    // MARK: LoadView
    override func loadView() {
        _setupScrollView()
        _setupTableView()
    }
    
    /// Initial scrollView setup
    private func _setupScrollView() {
        view = scrollView
    }
    
    /// Initial tableView setup
    private func _setupTableView() {
        tableView.style = .plain
        tableView.headerView = nil
        tableView.backgroundColor = .clear
        tableView.frame = scrollView.bounds
        tableView.intercellSpacing = NSSize(width: 0, height: 0)
        
        let column = NSTableColumn(identifier: .init(rawValue: "Main"))
        tableView.addTableColumn(column)
        scrollView.documentView = tableView
        scrollView.hasVerticalScroller = true
    }
    
    // MARK: ViewDidLayout
    override func viewDidLayout() {
        super.viewDidLayout()
        scrollView.layout()
    }
}
