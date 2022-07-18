//
//  SNButtonStyle.swift
//  Snippet
//
//  Created by Seb Vidal on 06/07/2022.
//

import SwiftUI

struct SNButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .overlay(.black.opacity(configuration.isPressed ? 0.5 : 0))
    }
}
