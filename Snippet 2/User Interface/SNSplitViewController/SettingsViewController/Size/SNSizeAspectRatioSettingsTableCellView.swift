//
//  SNSizeAspectRatioSettingsTableCellView.swift
//  Snippet
//
//  Created by Seb Vidal on 24/07/2022.
//

import Cocoa

class SNSizeAspectRatioSettingsTableCellView: NSTableRowView, SNSettingsTableCellView, NSCollectionViewDelegate, NSCollectionViewDataSource {
    var height: CGFloat = 422

    private var _titleLabel: SNLabel!
    private var _collectionView: NSCollectionView!
    private var _dividerView: SNSettingsDividerView!
    
    // MARK: init()
    init() {
        super.init(frame: NSRect.zero)
        _setupTitleLabel()
        _setupCollectionView()
        _setupDividerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _setupTitleLabel() {
        _titleLabel = SNLabel()
        _titleLabel.text = "Aspect Ratio:"
        _titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(_titleLabel)
        
        NSLayoutConstraint.activate([
            _titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            _titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18)
        ])
    }
    
    private func _setupCollectionView() {
        let layout = NSCollectionViewGridLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.maximumNumberOfColumns = 3
        layout.maximumItemSize = NSSize(width: 0, height: 82)
        
        _collectionView = NSCollectionView()
        _collectionView.delegate = self
        _collectionView.dataSource = self
        _collectionView.wantsLayer = true
        _collectionView.layer?.masksToBounds = false
        _collectionView.collectionViewLayout = layout
        _collectionView.translatesAutoresizingMaskIntoConstraints = false
        _collectionView.register(SNAspectRatioCollectionViewCell.self, forItemWithIdentifier: .init(rawValue: "Cell"))
        
        addSubview(_collectionView)
        
        NSLayoutConstraint.activate([
            _collectionView.topAnchor.constraint(equalTo: _titleLabel.bottomAnchor, constant: 10),
            _collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            _collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            _collectionView.heightAnchor.constraint(equalToConstant: 373)
        ])
    }
    
    private var presets = SNAspectRatio.presets
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return presets.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let cell = _collectionView.makeItem(withIdentifier: .init(rawValue: "Cell"), for: indexPath) as! SNAspectRatioCollectionViewCell
        cell.aspectRatio = presets[indexPath.item]
        cell.setupCell()
        
        return cell
    }
    
    private func _setupDividerView() {
        _dividerView = SNSettingsDividerView()
        _dividerView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(_dividerView)

        NSLayoutConstraint.activate([
            _dividerView.topAnchor.constraint(equalTo: _collectionView.bottomAnchor, constant: 12),
            _dividerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            _dividerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

class SNAspectRatioCollectionViewCell: NSCollectionViewItem {
    var aspectRatio: SNAspectRatio!
    
    private var button: SNButton = SNButton()
    
    override func loadView() {
        view = NSView()
        view.wantsLayer = true
        view.layer?.masksToBounds = false
    }
    
    func setupCell() {
        _setupButton()
    }
    
    private func _setupButton() {
        button.isSelectable = true
        button.selectionGroup = "aspectRatio"
        button.view = .aspectRatio(from: aspectRatio)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isSelected = CacheManager.shared.aspectRatio.preset == aspectRatio.preset
        button.label = aspectRatio.name.rawValue.replacingOccurrences(of: " ", with: "\n")
        button.action = { [unowned self] in
            CacheManager.shared.setAspectRatio(to: aspectRatio)
            CanvasManager.shared.updateAspectRatio()
        }

        view.addSubview(button)

        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.topAnchor),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
