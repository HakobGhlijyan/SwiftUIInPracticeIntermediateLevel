//
//  ImageTitleRowCell.swift
//  SwiftUIInPracticeIntermediateLevel
//
//  Created by Hakob Ghlijyan on 31.03.2024.
//

import SwiftUI

struct ImageTitleRowCell: View {
    var imageSize: CGFloat = 100
    var imageName: String = Constants.randomImage
    var title: String = "iPhone 8"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            ImageLoaderView(urlString: imageName)
                .frame(width: imageSize, height: imageSize)
            Text(title)
                .font(.callout)
                .foregroundStyle(.spotifyLigthGray)
                .lineLimit(2)
                .padding(4)
        }
        .frame(width: imageSize)
    }
        
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        ImageTitleRowCell()
    }
}
