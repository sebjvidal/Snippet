//
//  SNAspectRatio.swift
//  Snippet
//
//  Created by Seb Vidal on 24/07/2022.
//

import Cocoa

class SNAspectRatio: Codable {
    var name: Name
    var width: Double
    var height: Double
    var preset: Int?
    
    private init(name: Name, width: Double, height: Double, preset: Int?) {
        self.name = name
        self.width = width
        self.height = height
        self.preset = preset
    }
    
    private convenience init(name: Name, preset: Int?) {
        self.init(name: name, width: 0, height: 0, preset: preset)
    }
    
    convenience init(name: Name, width: Double, height: Double) {
        self.init(name: name, width: width, height: height, preset: nil)
    }
    
    private convenience init(name: Name) {
        self.init(name: name, width: 0, height: 0)
    }
}

extension SNAspectRatio {
    static let presets = [
        SNAspectRatio(name: .fill, preset: 0),
        SNAspectRatio(name: .fit, preset: 1),
        SNAspectRatio(name: .oneByOne, width: 1, height: 1, preset: 2),
        SNAspectRatio(name: .fourByThree, width: 4, height: 3, preset: 3),
        SNAspectRatio(name: .threeByFour, width: 3, height: 4, preset: 4),
        SNAspectRatio(name: .sixteenByNine, width: 16, height: 9, preset: 5),
        SNAspectRatio(name: .nineBySixteen, width: 9, height: 16, preset: 6),
        SNAspectRatio(name: .pinterest, width: 2, height: 3, preset: 7),
        SNAspectRatio(name: .twitterPost, width: 16, height: 9, preset: 8),
        SNAspectRatio(name: .twitterBanner, width: 3, height: 1, preset: 9),
        SNAspectRatio(name: .instagramPortrait, width: 4, height: 5, preset: 10),
        SNAspectRatio(name: .instagramLandscape, width: 1.91, height: 1, preset: 11),
    ]
}

extension SNAspectRatio {
    enum Name: String, Codable {
        case fill = "Fill"
        case fit = "Fit"
        case oneByOne = "1:1"
        case fourByThree = "4:3"
        case threeByFour = "3:4"
        case sixteenByNine = "16:9"
        case nineBySixteen = "9:16"
        case twitterPost = "Twitter"
        case twitterBanner = "Twitter Banner"
        case pinterest = "Pinterest"
        case instagramPortrait = "Instagram Portrait"
        case instagramLandscape = "Instagram Landscape"
        case custom = "Custom"
    }
}
