//
//  SNBackgroundGradientType.swift
//  Snippet
//
//  Created by Seb Vidal on 02/07/2022.
//

import Cocoa

enum SNBackgroundGradientType {
    case preset(index: Int)
    case custom(gradient: SNGradient)
}
