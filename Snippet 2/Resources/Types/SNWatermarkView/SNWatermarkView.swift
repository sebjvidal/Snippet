//
//  SNWatermarkView.swift
//  Snippet
//
//  Created by Seb Vidal on 24/07/2022.
//

import Cocoa
import SwiftUI

class SNWatermarkView: NSView, ObservableObject {
    private var _snWatermarkView: NSView!

    @Published var alignment: Alignment = .bottomLeading

    @Published var image: NSImage? = NSImage(named: "SnippetIconSmall")

    @Published var subtitle: String? = "https://sebvidal.com/snippet"

    @Published var title: String? = "Made with Snippet"

    // MARK: init(frame:)
    override init(frame: NSRect) {
        super.init(frame: frame)
        _setupWatermarkView()
    }

    // MARK: init?(coder:)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func _setupWatermarkView() {
        let root = _SNWatermarkView(snWatermarkView: self)
        let host = NSHostingController(rootView: root)
        _snWatermarkView = host.view
        _snWatermarkView.autoresizingMask = [.width, .height]

        addSubview(_snWatermarkView)
    }
}

struct _SNWatermarkView: View {
    @ObservedObject var snWatermarkView: SNWatermarkView
    
    var body: some View {
        HStack(spacing: 12) {
            if let image = snWatermarkView.image {
                Image(nsImage: image)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            }
            
            VStack(alignment: .leading) {
                if let title = snWatermarkView.title {
                    Text(title)
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                }
                
                if let subtitle = snWatermarkView.subtitle {
                    Text(subtitle)
                        .font(.system(size: 14))
                        .foregroundStyle(.secondary)
                }
            }
        }
        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2.5)
        .padding()
    }
}
