//
//  PlaylistDescriptionCell.swift
//  SwiftUIInPracticeIntermediateLevel
//
//  Created by Hakob Ghlijyan on 01.04.2024.
//

import SwiftUI

struct PlaylistDescriptionCell: View {
    var descriptionText: String = Product.mock.description
    var userName: String = "Hakob"
    var subheadline: String = "Some headline goes here"
    var onAddToPlaylistPressed: (() -> Void)? = nil
    var onDownloadPressed: (() -> Void)? = nil
    var onSharePressed: (() -> Void)? = nil
    var onEllipsisPressed: (() -> Void)? = nil
    var onShufflePressed: (() -> Void)? = nil
    var onPlayPressed: (() -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Text(descriptionText)
                .foregroundStyle(.spotifyLigthGray)
                .frame(maxWidth: .infinity, alignment: .leading)
            madeForYouSection
            Text(subheadline)
            buttonsRow
        }
        .font(.callout)
        .fontWeight(.medium)
        .foregroundStyle(.spotifyLigthGray)
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        PlaylistDescriptionCell()
            .padding()
    }
}

extension PlaylistDescriptionCell {
    private var madeForYouSection: some View {
        HStack(spacing: 8.0) {
            Image(systemName: "applelogo")
                .font(.title3)
                .foregroundStyle(.spotifyGreen)
            
            Text("Made for ")
            +
            Text(userName)
                .bold()
                .foregroundStyle(.spotifyWhite)
        }
    }
    
    private var buttonsRow: some View {
        HStack(spacing: 0.0) {
            HStack(spacing: 0.0) {
                Image(systemName: "plus.circle")
                    .padding(8)
                    .background(.black.opacity(0))
                    .onTapGesture { onAddToPlaylistPressed?() }
                Image(systemName: "arrow.down.circle")
                    .padding(8)
                    .background(.black.opacity(0))
                    .onTapGesture { onDownloadPressed?() }
                Image(systemName: "square.and.arrow.up")
                    .padding(8)
                    .background(.black.opacity(0))
                    .onTapGesture { onSharePressed?() }
                Image(systemName: "ellipsis")
                    .padding(8)
                    .background(.black.opacity(0))
                    .onTapGesture { onEllipsisPressed?() }
            }
            .offset(x: -8)
            .frame(maxWidth: .infinity, alignment: .leading)
        
            HStack(spacing: 8.0) {
                Image(systemName: "shuffle")
                    .font(.system(size: 24))
                    .background(.black.opacity(0))
                    .onTapGesture { onShufflePressed?() }
                Image(systemName: "play.circle.fill")
                    .font(.system(size: 46))
                    .background(.black.opacity(0))
                    .onTapGesture { onPlayPressed?() }
            }
            .foregroundStyle(.spotifyGreen)
        }
        .font(.title2)
    }
}
