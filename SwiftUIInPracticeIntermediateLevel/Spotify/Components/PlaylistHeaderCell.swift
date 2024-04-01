//
//  PlaylistHeaderCell.swift
//  SwiftUIInPracticeIntermediateLevel
//
//  Created by Hakob Ghlijyan on 01.04.2024.
//

import SwiftUI
import SwiftfulUI

struct PlaylistHeaderCell: View {
    var height: CGFloat = 300
    var title: String = "Some playlist title goes here"
    var subTitle: String = "Subtitle goes here"
    var imageName: String = Constants.randomImage
    var shadowColor: Color = .spotifyBlack.opacity(0.8)
    
    var body: some View {
        Rectangle()
            .opacity(0)
            .overlay(
                ImageLoaderView(urlString: imageName)
            )
            .overlay (
                VStack(alignment: .leading, spacing: 8.0) {
                    Text(subTitle)
                        .font(.headline)
                    Text(title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .foregroundStyle(.spotifyWhite)
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    LinearGradient(
                        colors: [shadowColor.opacity(0), shadowColor],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                
                , alignment: .bottomLeading
            )
            .asStretchyHeader(startingHeight: height)
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        
        ScrollView {
            PlaylistHeaderCell()
        }
        .ignoresSafeArea()
    }
   
}
