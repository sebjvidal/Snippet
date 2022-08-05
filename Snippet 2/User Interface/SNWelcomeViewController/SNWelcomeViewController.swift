//
//  SNWelcomeViewController.swift
//  Snippet
//
//  Created by Seb Vidal on 13/05/2022.
//

import Cocoa

class SNWelcomeViewController: NSViewController {
    private var appIcon: NSImageView!
    private var welcomeLabel: NSTextField!
    private var startButton: NSButton!
    private var privacyImage: NSImageView!
    private var privacyText: NSTextField!
    private var containerView: NSView!
    
    private var tintColour = NSColor(displayP3Red: 216/255, green: 56/255, blue: 223/255, alpha: 1)
    
    override func loadView() {
        view = NSView(frame: NSRect(x: 0, y: 0, width: 640, height: 600))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppIcon()
        setupWelcomeLabel()
        setupStartButton()
        setupPrivacyPolicy()
        setupContainerView()
        setupFeatures()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        let window = view.window! as NSWindow
        window.preventsApplicationTerminationWhenModal = false
        window.styleMask.remove(.resizable)
    }
    
    private func setupAppIcon() {
        appIcon = NSImageView()
        appIcon.image = NSImage(named: "SnippetIcon")
        appIcon.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(appIcon)
        
        NSLayoutConstraint.activate([
            appIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appIcon.topAnchor.constraint(equalTo: view.topAnchor, constant: 58),
            appIcon.widthAnchor.constraint(equalToConstant: 80),
            appIcon.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func setupWelcomeLabel() {
        welcomeLabel = NSTextField()
        welcomeLabel.isBezeled = false
        welcomeLabel.isEditable = false
        welcomeLabel.backgroundColor = .clear
        welcomeLabel.stringValue = "Welcome to Snippet"
        welcomeLabel.font = .systemFont(ofSize: 23.5, weight: .bold)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(welcomeLabel)
        
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.topAnchor.constraint(equalTo: appIcon.bottomAnchor, constant: 17),
            welcomeLabel.widthAnchor.constraint(equalToConstant: welcomeLabel.intrinsicContentSize.width),
            welcomeLabel.heightAnchor.constraint(equalToConstant: welcomeLabel.intrinsicContentSize.height)
        ])
    }
    
    private func setupStartButton() {
        startButton = NSButton()
        startButton.title = "Get Started"
        startButton.bezelColor = tintColour
        startButton.bezelStyle = .rounded
        startButton.controlSize = .large
        startButton.action = #selector(startButtonTapped)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(startButton)
        
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25),
            startButton.widthAnchor.constraint(equalToConstant: 200),
            startButton.heightAnchor.constraint(equalToConstant: 27)
        ])
    }
    
    @objc func startButtonTapped() {
        UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
        NSApp.mainWindow?.animator().endSheet(NSApp.keyWindow!)
    }
    
    private func setupPrivacyPolicy() {
        privacyText = NSTextField()
        privacyText.isBezeled = false
        privacyText.isEditable = false
        privacyText.alignment = .center
        privacyText.backgroundColor = .clear
        privacyText.textColor = .secondaryLabelColor
        privacyText.stringValue = "Snippet does not collect analytics, sell your data to third parties, show ads, or track you across apps and websites. Your data is stored securely and privately on your device."
        privacyText.font = .systemFont(ofSize: 10, weight: .medium)
        privacyText.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(privacyText)
        
        NSLayoutConstraint.activate([
            privacyText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            privacyText.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -30),
            privacyText.widthAnchor.constraint(equalToConstant: 450)
        ])
        
        privacyImage = NSImageView()
        privacyImage.image = NSImage(named: "PrivacyPolicy")
        privacyImage.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(privacyImage)
        
        NSLayoutConstraint.activate([
            privacyImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            privacyImage.bottomAnchor.constraint(equalTo: privacyText.topAnchor, constant: -8),
            privacyImage.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func setupContainerView() {
        containerView = NSView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 40),
            containerView.widthAnchor.constraint(equalToConstant: 450),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -30)
        ])
    }
    
    private func setupFeatures() {
        let syntax = Feature()
        syntax.icon = "chevron.left.forwardslash.chevron.right"
        syntax.title = "Syntax Highlighting"
        syntax.detail = "Best in class code highlighting, with language support for Swift, Python, JavaScript and TypeScript."
        syntax.iconAlignmentOffset = CGPoint(x: 0, y: 8)
        
        let feature1 = SNFeatureView(feature: syntax)
        feature1.tint = tintColour
        feature1.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(feature1)
        
        NSLayoutConstraint.activate([
            feature1.topAnchor.constraint(equalTo: containerView.topAnchor),
            feature1.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            feature1.widthAnchor.constraint(equalToConstant: 450),
            feature1.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        let backgrounds = Feature()
        backgrounds.icon = "slider.horizontal.3"
        backgrounds.title = "Make it Yours"
        backgrounds.detail = "Choose from a variety of backgrounds, appearances, fonts, themes and editor options."
        backgrounds.iconAlignmentOffset = CGPoint(x: 0, y: 7)
        
        let feature2 = SNFeatureView(feature: backgrounds)
        feature2.tint = tintColour
        feature2.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(feature2)
        
        NSLayoutConstraint.activate([
            feature2.topAnchor.constraint(equalTo: feature1.bottomAnchor, constant: 20),
            feature2.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            feature2.widthAnchor.constraint(equalToConstant: 450),
            feature2.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        let export = Feature()
        export.icon = "square.and.arrow.up"
        export.title = "Easy Export"
        export.detail = "Share your Snippet in a pinch with fast options to save or share your code to social media."
        export.iconAlignmentOffset = CGPoint(x: 0, y: 8)
        export.iconSize = 28
        
        let feature3 = SNFeatureView(feature: export)
        feature3.tint = tintColour
        feature3.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(feature3)
        
        NSLayoutConstraint.activate([
            feature3.topAnchor.constraint(equalTo: feature2.bottomAnchor, constant: 20),
            feature3.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            feature3.widthAnchor.constraint(equalToConstant: 450),
            feature3.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}

class Feature {
    var icon: String!
    var title: String!
    var detail: String!
    
    var iconSize: CGFloat = 35.0
    var iconAlignmentOffset = CGPoint(x: 0.0, y: 0.0)
}

class SNFeatureView: NSView {
    var feature: Feature
    
    var tint: NSColor? {
        willSet {
            if let _ = iconView {
                iconView.contentTintColor = newValue
            }
        }
    }
    
    private var iconView: NSImageView!
    private var titleLabel: NSTextField!
    private var detailLabel: NSTextField!
    
    private var symbolConfig: NSImage.SymbolConfiguration!
    
    init(feature: Feature) {
        self.feature = feature
        self.symbolConfig = NSImage.SymbolConfiguration(pointSize: feature.iconSize, weight: .bold)
        
        super.init(frame: CGRect.zero)
        
        layoutIconView()
        layoutTitleLabel()
        layoutDetailLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func layoutIconView() {
        iconView = NSImageView()
        iconView.imageAlignment = .alignTop
        iconView.contentTintColor = tint
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.image = NSImage(
            systemSymbolName: feature.icon,
            accessibilityDescription: feature.title
        )?.withSymbolConfiguration(symbolConfig)
        
        addSubview(iconView)
        
        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: topAnchor, constant: feature.iconAlignmentOffset.y),
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func layoutTitleLabel() {
        titleLabel = NSTextField()
        titleLabel.isBezeled = false
        titleLabel.isEditable = false
        titleLabel.backgroundColor = .clear
        titleLabel.stringValue = feature.title
        titleLabel.font = .systemFont(ofSize: 11.5, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 10),
            titleLabel.widthAnchor.constraint(equalToConstant: titleLabel.intrinsicContentSize.width),
            titleLabel.heightAnchor.constraint(equalToConstant: titleLabel.intrinsicContentSize.height)
        ])
    }
    
    private func layoutDetailLabel() {
        detailLabel = NSTextField()
        detailLabel.isBezeled = false
        detailLabel.isEditable = false
        detailLabel.backgroundColor = .clear
        detailLabel.stringValue = feature.detail
        detailLabel.font = .systemFont(ofSize: 12)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false

        addSubview(detailLabel)

        NSLayoutConstraint.activate([
            detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1),
            detailLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 10),
            detailLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
