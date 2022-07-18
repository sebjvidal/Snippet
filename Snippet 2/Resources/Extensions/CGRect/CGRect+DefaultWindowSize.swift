//
//  CGRect+DefaultWindowSize.swift
//  Snippet
//
//  Created by Seb Vidal on 24/06/2022.
//

import Cocoa

extension CGRect {
    static var defaultWindowSize: CGRect {
        let width = 400.0
        let height = 400.0
        
        let screenSize = NSScreen.main?.frame.size ?? .zero
        
        let x = (screenSize.width / 2.0) - (width / 2.0)
        let y = (screenSize.height / 2.0) - (height / 2.0)

        return .init(x: x, y: y, width: width, height: height)
    }
}
