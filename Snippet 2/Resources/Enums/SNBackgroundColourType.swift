//
//  SNBackgroundColourType.swift
//  Snippet
//
//  Created by Seb Vidal on 02/07/2022.
//

import Cocoa

enum SNBackgroundColourType{
    case preset(index: Int)
    case custom(colour: HSV)
}
