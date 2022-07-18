//
//  SNButtonImageView.swift
//  Snippet
//
//  Created by Seb Vidal on 14/07/2022.
//

import SwiftUI

struct _SNButtonImageView: View {
    var image: String
    
    // MARK: Body
    var body: some View {
        Image(image)
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
}
