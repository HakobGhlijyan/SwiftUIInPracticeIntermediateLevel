//
//  ImageLoaderView.swift
//  SwiftUIInPracticeIntermediateLevel
//
//  Created by Hakob Ghlijyan on 29.03.2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageLoaderView: View {
    
    var urlString: String = Constants.randomImage
    var contentMode: ContentMode = .fill
    
    var body: some View {
        Rectangle()
            .opacity(0)
            .overlay {
                WebImage(url: URL(string: urlString))
                    .resizable()
                    .indicator(.activity)
                    .aspectRatio(contentMode: contentMode)
                    .allowsHitTesting(false)  // dont pad this photo
            }
            .clipped()
    }
}

#Preview {
    ImageLoaderView()
        .cornerRadius(30)
        .padding(40)
        .padding(.vertical, 60)
}
