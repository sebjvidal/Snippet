//
//  RGBtoHSV.swift
//  Snippet
//
//  Created by Seb Vidal on 06/02/2022.
//

import Cocoa

struct RGB {
    let r: Float
    let g: Float
    let b: Float
    
    static func hsv(r: Float, g: Float, b: Float) -> HSV {
        let min = r < g ? (r < b ? r : b) : (g < b ? g : b)
        let max = r > g ? (r > b ? r : b) : (g > b ? g : b)
        
        let v = max
        let delta = max - min
        
        guard delta > 0.00001 else { return HSV(h: 0, s: 0, v: max) }
        guard max > 0 else { return HSV(h: -1, s: 0, v: v) }
        let s = delta / max
        
        let hue: (Float, Float) -> Float = { max, delta -> Float in
            if r == max { return (g-b)/delta }
            else if g == max { return 2 + (b-r)/delta }
            else { return 4 + (r-g)/delta }
        }
        
        let h = hue(max, delta) * 60
        
        return HSV(h: (h < 0 ? h+360 : h) , s: s, v: v)
    }
    
    static func hsv(rgb: RGB) -> HSV {
        return hsv(r: rgb.r, g: rgb.g, b: rgb.b)
    }
    
    var hsv: HSV {
        return RGB.hsv(rgb: self)
    }
}

struct HSV: Codable {
    let h: Float
    let s: Float
    let v: Float
    
    static func rgb(h: Float, s: Float, v: Float) -> RGB {
        if s == 0 { return RGB(r: v, g: v, b: v) }
        
        let angle = (h >= 360 ? 0 : h)
        let sector = angle / 60
        let i = floor(sector)
        let f = sector - i
        
        let p = v * (1 - s)
        let q = v * (1 - (s * f))
        let t = v * (1 - (s * (1 - f)))
        
        switch(i) {
        case 0:
            return RGB(r: v, g: t, b: p)
        case 1:
            return RGB(r: q, g: v, b: p)
        case 2:
            return RGB(r: p, g: v, b: t)
        case 3:
            return RGB(r: p, g: q, b: v)
        case 4:
            return RGB(r: t, g: p, b: v)
        default:
            return RGB(r: v, g: p, b: q)
        }
    }
    
    static func rgb(hsv: HSV) -> RGB {
        return rgb(h: hsv.h, s: hsv.s, v: hsv.v)
    }
    
    var rgb: RGB {
        return HSV.rgb(hsv: self)
    }
    
    var cgColor: CGColor {
        return CGColor(colorSpace: CGColorSpace(name: CGColorSpace.displayP3)!, components: [CGFloat(rgb.r), CGFloat(rgb.g), CGFloat(rgb.b), 1])!
    }
    
    var nsColor: NSColor {
        return NSColor(displayP3Red: CGFloat(rgb.r), green: CGFloat(rgb.g), blue: CGFloat(rgb.b), alpha: 1)
    }
    
    var hex: String {
        let red = rgb.r > 1 ? 1 : rgb.r
        let green = rgb.g > 1 ? 1 : rgb.g
        let blue = rgb.b > 1 ? 1 : rgb.b
        
        return String(format:"%02X", Int(255 * red)) + String(format:"%02X", Int(255 * green)) + String(format:"%02X", Int(255 * blue))
    }
}
