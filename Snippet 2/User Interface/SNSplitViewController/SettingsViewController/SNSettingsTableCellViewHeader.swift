//
//  SNSettingsTableCellViewHeader.swift
//  Snippet
//
//  Created by Seb Vidal on 05/07/2022.
//

import Cocoa

class SNSettingsTableCellViewHeader: NSTableRowView, SNSettingsTableCellView {
    var height: CGFloat = 44
    
    private var _headerLabel: SNLabel!
    private var _dividerView: SNSettingsDividerView!
    
    var headerText: String {
        get {
            return _headerLabel.text
        }
        
        set {
            _headerLabel.text = newValue
        }
    }
    
    init(named name: String) {
        super.init(frame: NSRect.zero)
        _setupHeader(withName: name)
        _setupDividerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _setupHeader(withName name: String) {
        _headerLabel = SNLabel()
        _headerLabel.text = name
        _headerLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        _headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_headerLabel)
        
        NSLayoutConstraint.activate([
            _headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            _headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            _headerLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func _setupDividerView() {
        _dividerView = SNSettingsDividerView()
        _dividerView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_dividerView)
        
        NSLayoutConstraint.activate([
            _dividerView.topAnchor.constraint(equalTo: _headerLabel.bottomAnchor, constant: 12),
            _dividerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            _dividerView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
}
