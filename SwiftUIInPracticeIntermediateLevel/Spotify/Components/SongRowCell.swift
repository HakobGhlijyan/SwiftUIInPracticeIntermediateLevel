//
//  SongRowCell.swift
//  SwiftUIInPracticeIntermediateLevel
//
//  Created by Hakob Ghlijyan on 01.04.2024.
//

import SwiftUI

struct SongRowCell: View {
    var imageSize: CGFloat = 50
    var imageName: String = Constants.randomImage
    var title: String = "Some Title"
    var subtitle: String? = "Some Subtitle"
    
    var onCellPressed: (() -> Void)? = nil
    var onEllipsisPressed: (() -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 8.0) {
            ImageLoaderView(urlString: imageName)
                .frame(width: imageSize, height: imageSize)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundStyle(.spotifyWhite)
                if let subtitle {
                    Text(subtitle)
                        .font(.callout)
                        .foregroundStyle(.spotifyLigthGray)
                }
            }
            .lineLimit(2)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "ellipsis")
                .font(.subheadline)
                .foregroundStyle(.spotifyWhite)
                .padding(16)
                .background(.black.opacity(0))
                .onTapGesture { onEllipsisPressed?() }
        }
        .background(.red.opacity(0))
        .onTapGesture {
            onCellPressed?()
        }
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        
        VStack {
            ForEach(0 ..< 4) { _ in
                SongRowCell()
            }
        }
    }
}
