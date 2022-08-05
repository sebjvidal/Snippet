//
//  SNGradient.swift
//  Snippet
//
//  Created by Seb Vidal on 02/07/2022.
//

import Cocoa

class SNGradient: SNBackground, Codable {
    var colours: [HSV]
    var locations: [NSNumber]
    var angle: CGFloat
    var type: CAGradientLayerType
    let preset: Int?
    
    private init(
        colours: [HSV] = [
            HSV(h: 0, s: 0, v: 0),
            HSV(h: 0, s: 0, v: 0)
        ],
        locations: [NSNumber] = [0, 1],
        angle: CGFloat = 315,
        type: CAGradientLayerType = .axial,
        preset: Int? = nil
    ) {
        self.colours = colours
        self.locations = locations
        self.angle = angle
        self.type = type
        self.preset = preset
    }
    
    convenience init(
        colours: [HSV] = [
            HSV(h: 0, s: 0, v: 0),
            HSV(h: 0, s: 0, v: 0)
        ],
        locations: [NSNumber] = [0, 1],
        angle: CGFloat = 315,
        type: CAGradientLayerType = .axial
    ) {
        self.init(colours: colours, locations: locations, angle: angle, type: type, preset: nil)
    }
    
    convenience init(colours: [HSV]) {
        self.init(colours: colours, locations: [0, 1], angle: 315, type: .axial)
    }
    
    enum CodingKeys: String, CodingKey {
        case colours
        case locations
        case angle
        case type
        case preset
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(colours, forKey: .colours)
        try container.encode(locations as? [Int], forKey: .locations)
        try container.encode(angle, forKey: .angle)
        try container.encode(type.rawValue, forKey: .type)
        try container.encode(preset, forKey: .preset)
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        colours = try values.decode([HSV].self, forKey: .colours)
        locations = try values.decode([Int].self, forKey: .locations) as [NSNumber]
        angle = try values.decode(CGFloat.self, forKey: .angle)
        type = try CAGradientLayerType(rawValue: values.decode(String.self, forKey: .type))
        preset = try values.decodeIfPresent(Int.self, forKey: .preset)
    }
    
    func caGradientLayer() -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.colors = colours
        layer.locations = locations
        layer.calculatePoints(for: angle, type: type)
        layer.type = type
        
        return layer
    }
    
    func reverseColours() {
        colours = colours.reversed()
    }
}

extension SNGradient {
    static let presets = [
        SNGradient(
            colours: [
                HSV(h: 321, s: 0.769, v: 0.816),
                HSV(h: 255, s: 0.741, v: 0.894)
            ],
            angle: 315,
            preset: 0
        )
        ,
        SNGradient(
            colours: [
                HSV(h: 39, s: 0.76, v: 0.945),
                HSV(h: 328, s: 0.781, v: 0.843)
            ],
            angle: 315,
            preset: 1
        ),
        SNGradient(
            colours: [
                HSV(h: 59, s: 0.587, v: 0.996),
                HSV(h: 24, s: 0.679, v: 0.929)
            ],
            angle: 315,
            preset: 2
        ),
        SNGradient(
            colours: [
                HSV(h: 180, s: 0.53, v: 0.976),
                HSV(h: 273, s: 0.885, v: 0.957)
            ],
            angle: 315,
            preset: 3
        ),
        SNGradient(
            colours: [
                HSV(h: 327, s: 0.56, v: 1),
                HSV(h: 284, s: 1, v: 0.70)
            ],
            angle: 315,
            preset: 4
        ),
        SNGradient(
            colours: [
                HSV(h: 174, s: 0.447, v: 0.95),
                HSV(h: 139, s: 0.74, v: 0.85)
            ],
            angle: 315,
            preset: 5
        )
    ]
}

extension SNGradient {
    func applyBackground(to view: SNImageView) {
        NSAnimationContext().duration = 0
        view.gradientLayer.type = type
        view.gradientLayer.locations = [0, 1]
        view.gradientLayer.colors = colours.map { $0.cgColor }
        view.gradientLayer.calculatePoints(for: angle, type: type)
    }
}
