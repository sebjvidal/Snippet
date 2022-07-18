//
//  SNButtonNoneControlsView.swift
//  Snippet
//
//  Created by Seb Vidal on 10/07/2022.
//

import SwiftUI

struct _SNButtonNoneControlsView: View {
    // MARK: Body
    var body: some View {
        ZStack {
            LinearGradient(colors: [
                Color(nsColor: .init(named: "GradientButtonStart")!),
                Color(nsColor: .init(named: "GradientButtonEnd")!)
            ], startPoint: .top, endPoint: .bottom)
            
            let size: CGFloat = 9
            
            HStack(spacing: 6) {
                Circle()
                    .foregroundColor(Color.clear)
                    .frame(width: size, height: size)
                
                Circle()
                    .foregroundColor(Color.clear)
                    .frame(width: size, height: size)
                
                Circle()
                    .foregroundColor(Color.clear)
                    .frame(width: size, height: size)
            }
            .padding(12)
            .background {
                RoundedRectangle(cornerRadius: 7, style: .continuous)
                    .foregroundStyle(Color("WindowBackground"))
                    .padding([.bottom, .trailing], -9999)
            }
        }
    }
}
