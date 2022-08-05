//
//  AnyView+SNButtonView.swift
//  Snippet
//
//  Created by Seb Vidal on 10/07/2022.
//

import SwiftUI

extension AnyView {
    /// EmptyView
    static let emptyView = AnyView(EmptyView())
    
    /// AspectRatio
    static func aspectRatio(from aspectRatio: SNAspectRatio) -> AnyView {
        return AnyView(_SNButtonAspectRatioView(aspectRatio: aspectRatio))
    }
    
    /// Appearance
    static let automaticAppearance = AnyView(_SNButtonAutomaticAppearanceView())
    static let lightAppearance = AnyView(_SNButtonLightAppearanceView())
    static let darkAppearance = AnyView(_SNButtonDarkAppearanceView())
    
    /// Controls
    static let colourfulControls = AnyView(_SNButtonColourfulControlsView())
    static let graphiteControls = AnyView(_SNButtonGraphiteControlsView())
    static let noneControls = AnyView(_SNButtonNoneControlsView())
    
    /// Colour
    static func colour(from solidColour: SNSolidColour) -> AnyView {
        return AnyView(_SNButtonColourView(colour: solidColour.color))
    }
    
    /// Gradient
    static func gradient(from gradient: SNGradient) -> AnyView {
        return AnyView(_SNButtonGradientView(gradient: gradient))
    }
    
    /// Image
    static func image(from image: SNImage) -> AnyView {
        return AnyView(_SNButtonImageView(image: image.thumbnail))
    }
}
