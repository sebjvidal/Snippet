//
//  SNButtonAspectRatioView.swift
//  Snippet
//
//  Created by Seb Vidal on 24/07/2022.
//

import SwiftUI

struct _SNButtonAspectRatioView: View {
    var aspectRatio: SNAspectRatio
    
    // MARK: Body
    var body: some View {
        ZStack {
            LinearGradient(colors: [
                Color(nsColor: .init(named: "SecondaryGradientButtonStart")!),
                Color(nsColor: .init(named: "SecondaryGradientButtonEnd")!)
            ], startPoint: .top, endPoint: .bottom)
            
            if aspectRatio.name == .fill {
                LinearGradient(colors: [
                    Color(nsColor: .init(named: "GradientButtonStart")!),
                    Color(nsColor: .init(named: "GradientButtonEnd")!)
                ], startPoint: .top, endPoint: .bottom)
            }
            
            ZStack(alignment: .topLeading) {
                Color("WindowBackground")

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
                .compositingGroup()
                .padding(4)
                .scaledToFit()
            }
            .clipShape(RoundedRectangle(cornerRadius: 3, style: .continuous))
            .aspectRatio(aspectRatioCalc, contentMode: .fit)
            .padding(10)
            .background {
                LinearGradient(colors: [
                    Color(nsColor: .init(named: "GradientButtonStart")!),
                    Color(nsColor: .init(named: "GradientButtonEnd")!)
                ], startPoint: .top, endPoint: .bottom)
            }
            .padding(.vertical, isFillOrFit ? 4: 0)
            .padding(isFillOrFit ? 4 : 0)
        }
    }
    
    var isFillOrFit: Bool {
        return aspectRatio.name == .fill || aspectRatio.name == .fit
    }
    
    var aspectRatioCalc: Double {
        if isFillOrFit {
            return 5/3
        } else {
            return aspectRatio.width / aspectRatio.height
        }
    }
}
