//
//  SNBackgroundType.swift
//  Snippet
//
//  Created by Seb Vidal on 02/07/2022.
//

import Cocoa

enum SNBackgroundType{
    case none
    case solidColour(type: SNBackgroundColourType)
    case gradient(type: SNBackgroundGradientType)
    case image(type: SNBackgroundImageType)
}
