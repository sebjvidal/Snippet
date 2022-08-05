//
//  SNSolidColour.swift
//  Snippet
//
//  Created by Seb Vidal on 03/07/2022.
//

import Cocoa
import SwiftUI

class SNSolidColour: SNBackground, Codable {
    var colour: HSV
    var preset: Int?
    
    // MARK: Private Init
    private init(colour: HSV, preset: Int? = nil) {
        self.colour = colour
        self.preset = preset
    }
    
    // MARK: Convenience Init
    convenience init(colour: HSV) {
        self.init(colour: colour, preset: nil)
    }
}

extension SNSolidColour {
    static let presets = [
        SNSolidColour(colour: HSV(h: 094, s: 0.464, v: 0.718), preset: 0),
        SNSolidColour(colour: HSV(h: 004, s: 0.609, v: 0.753), preset: 1),
        SNSolidColour(colour: HSV(h: 290, s: 0.507, v: 0.557), preset: 2),
        SNSolidColour(colour: HSV(h: 041, s: 0.592, v: 0.914), preset: 3),
        SNSolidColour(colour: HSV(h: 028, s: 0.656, v: 0.855), preset: 4),
        SNSolidColour(colour: HSV(h: 209, s: 0.560, v: 0.820), preset: 5),
    ]
}

extension SNSolidColour {
    func applyBackground(to view: SNImageView) {
        NSAnimationContext().duration = 0
        view.layer?.backgroundColor = cgColor
    }
}

extension SNSolidColour {
    var nsColor: NSColor {
        let rgb = colour.rgb
        let red = CGFloat(rgb.r)
        let green = CGFloat(rgb.g)
        let blue = CGFloat(rgb.b)
        
        return NSColor(displayP3Red: red, green: green, blue: blue, alpha: 1)
    }
    
    var cgColor: CGColor {
        return nsColor.cgColor
    }
    
    var color: Color {
        return Color(nsColor: nsColor)
    }
}
