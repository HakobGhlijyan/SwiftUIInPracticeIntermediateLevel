//
//  SpotifyNewReleaseCell.swift
//  SwiftUIInPracticeIntermediateLevel
//
//  Created by Hakob Ghlijyan on 30.03.2024.
//

import SwiftUI

struct SpotifyNewReleaseCell: View {
    var imageName: String = Constants.randomImage
    var headline: String? = "New Release from"
    var subheadline: String? = "Some Artist"
    var title: String? = "Some Playlist"
    var subtitle: String? = "Single - Title"
    var onAddToPlaylistPressed: (() -> Void)? = nil
    var onPlayPressed: (() -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 8) {
                ImageLoaderView(urlString: imageName)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 2.0) {
                    if let headline {
                        Text(headline)
                            .font(.callout)
                            .foregroundStyle(.spotifyLigthGray)
                    }
                    if let subheadline {
                        Text(subheadline)
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundStyle(.spotifyLigthGray)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                ImageLoaderView(urlString: imageName)
                    .frame(width: 140, height: 140)

                VStack(alignment: .leading, spacing: 32) {
                    VStack(alignment: .leading, spacing: 2) {
                        if let title {
                            Text(title)
                                .fontWeight(.semibold)
                                .foregroundStyle(.spotifyWhite)
                        }
                        if let subtitle {
                            Text(subtitle)
                                .foregroundStyle(.spotifyLigthGray)
                        }
                    }
                    .font(.callout)
                    
                    HStack(spacing: 0.0) {
                        Image(systemName: "plus.circle")
                            .foregroundStyle(.spotifyLigthGray)
                            .font(.title3)
                            .padding(4)
                            .background(Color.clear)
                            .onTapGesture {
                                onAddToPlaylistPressed?()
                            }
                            .offset(x: -4)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image(systemName: "play.circle.fill")
                            .foregroundStyle(.spotifyWhite)
                            .font(.title)
                    }
                }
                .padding(.trailing, 16)
                
            }
            .themeColor(isSelected: false)
            .cornerRadius(8)
            .onTapGesture {
                onPlayPressed?()
            }
        }
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        
        SpotifyNewReleaseCell()
            .padding()
    }
}
