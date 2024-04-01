//
//  SpotifyRecentsCell.swift
//  SwiftUIInPracticeIntermediateLevel
//
//  Created by Hakob Ghlijyan on 30.03.2024.
//

import SwiftUI

struct SpotifyRecentsCell: View {
    var imageName: String = Constants.randomImage
    var title: String = "Some random title"
    
    var body: some View {
        HStack(spacing: 16.0) {
            ImageLoaderView(urlString: imageName)
                .frame(width: 55, height: 55)
            Text(title)
                .font(.callout)
                .fontWeight(.semibold)
                .lineLimit(2)
        }
        .padding(.trailing, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .themeColor(isSelected: false)
        .cornerRadius(6)

    }
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        
        VStack {
            HStack {
                SpotifyRecentsCell()
                SpotifyRecentsCell()
            }
            HStack {
                SpotifyRecentsCell()
                SpotifyRecentsCell()
            }
        }
    }
}
