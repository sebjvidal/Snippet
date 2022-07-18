//
//  SNButtonGradientView.swift
//  Snippet
//
//  Created by Seb Vidal on 10/07/2022.
//

import SwiftUI

struct _SNButtonGradientView: View {
    var gradient: SNGradient
    
    var body: some View {
        LinearGradient(
            colors: gradient.colours.map {
                return Color(nsColor: $0.nsColor)
            },
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
