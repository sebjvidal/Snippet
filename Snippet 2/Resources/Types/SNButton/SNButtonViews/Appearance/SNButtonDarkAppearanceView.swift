//
//  SNButtonDarkAppearanceView.swift
//  Snippet
//
//  Created by Seb Vidal on 10/07/2022.
//

import SwiftUI

struct _SNButtonDarkAppearanceView: View {
    // MARK: Body
    var body: some View {
        ZStack {
            LinearGradient(colors: [
                Color(nsColor: .init(named: "GradientButtonStart")!),
                Color(nsColor: .init(named: "GradientButtonEnd")!)
            ], startPoint: .top, endPoint: .bottom)
            .colorScheme(.dark)
            
            ZStack(alignment: .topLeading) {
                Color("WindowBackground")
                    .colorScheme(.dark)
                
                let size: CGFloat = 3
                
                HStack(spacing: 2) {
                    Circle()
                        .foregroundColor(Color("CloseControl"))
                        .frame(width: size, height: size)
                    
                    Circle()
                        .foregroundColor(Color("MinimiseControl"))
                        .frame(width: size, height: size)
                    
                    Circle()
                        .foregroundColor(Color("RestoreControl"))
                        .frame(width: size, height: size)
                }
                .padding(4)
            }
            .clipShape(RoundedRectangle(cornerRadius: 3, style: .continuous))
            .padding(10)
        }
    }
}
