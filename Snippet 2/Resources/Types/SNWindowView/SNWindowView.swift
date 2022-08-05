//
//  SNWindowView.swift
//  Snippet
//
//  Created by Seb Vidal on 25/07/2022.
//

import Cocoa
import SwiftUI

class SNWindowView: NSView, ObservableObject {
    private var _snWindowView: _SNWindowView!
    
    @Published var opacity: Double = 0.5
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        _setupWindowView()
        wantsLayer = true
        layer?.masksToBounds = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _setupWindowView() {
        _snWindowView = _SNWindowView(snWindowView: self)
        
        let host = NSHostingView(rootView: _snWindowView)
        host.wantsLayer = true
        host.layer?.masksToBounds = false
        host.autoresizingMask = [.width, .height]
        
        addSubview(host)
    }
}

private struct _SNWindowView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject var snWindowView: SNWindowView
    
    var body: some View {
        if colorScheme == .light {
            ZStack {
                _SNWindowViewVisualEffectView()
                    .overlay(Color("WindowBackground").opacity(snWindowView.opacity))
                    .clipShape(RoundedRectangle(cornerRadius: 11.5, style: .continuous))
                    .shadow(color: .black.opacity(0.325), radius: 15, x: 0, y: 15)
                    .padding(0.5)
                    .overlay {
                        RoundedRectangle(cornerRadius: 11.5, style: .continuous)
                            .strokeBorder(.white.opacity(0.4), lineWidth: 1)
                            .padding(.top, 0.5)
                            .padding(.leading, -1)
                            .padding(.trailing, -1)
                            .padding(.bottom, -10)
                            .clipShape(RoundedRectangle(cornerRadius: 11.5, style: .continuous))
                    }
                
                RoundedRectangle(cornerRadius: 11.5, style: .continuous)
                    .strokeBorder(.black.opacity(0.2), lineWidth: 0.5)
                
                
            }
        } else {
            ZStack {
                _SNWindowViewVisualEffectView()
                    .overlay(Color("WindowBackground").opacity(snWindowView.opacity))
                    .clipShape(RoundedRectangle(cornerRadius: 11.5, style: .continuous))
                    .foregroundStyle(.ultraThickMaterial)
                    .shadow(color: .black.opacity(0.6), radius: 15, x: 0, y: 15)
                    .padding(0.5)
                    .overlay {
                        RoundedRectangle(cornerRadius: 11.25, style: .continuous)
                            .strokeBorder(.white.opacity(0.2), lineWidth: 1)
                            .padding(.top, 0.5)
                            .padding(.leading, 0.5)
                            .padding(.trailing, 0.5)
                            .padding(.bottom, 0.5)
                            .clipShape(RoundedRectangle(cornerRadius: 11.5, style: .continuous))
                    }
                
                RoundedRectangle(cornerRadius: 11.25, style: .continuous)
                    .strokeBorder(.black.opacity(0.5), lineWidth: 1)
            }
        }
    }
}

private struct _SNWindowViewVisualEffectView: NSViewRepresentable {
    func makeNSView(context: Context) -> some NSView {
        let view = NSVisualEffectView()
        view.state = .active
        view.material = .sidebar
        view.blendingMode = .withinWindow
        
        return view
    }
    
    func updateNSView(_ nsView: NSViewType, context: Context) {}
}
