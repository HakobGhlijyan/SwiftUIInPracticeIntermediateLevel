//
//  NetflixHeroCell.swift
//  SwiftUIInPracticeIntermediateLevel
//
//  Created by Hakob Ghlijyan on 12.04.2024.
//

import SwiftUI
import SwiftfulUI

struct NetflixHeroCell: View {
    var imageName: String = Constants.randomImage
    var isNetflixFilm: Bool = true
    var title: String = "Players"
    var categories:[String] = ["Raunchy", "Romantic", "Comedy"]
    
    var onBackgroundPressed: (() -> Void)? = nil
    var onPlayPressed: (() -> Void)? = nil
    var onMyListPressed: (() -> Void)? = nil
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ImageLoaderView(urlString: imageName)
            
            VStack(spacing: 16) {
                //MARK: - Title
                headerSection
//                VStack(spacing: 0) {
//                    if isNetflixFilm {
//                        HStack(spacing: 8.0) {
//                            Text("N")
//                                .foregroundStyle(.netflixRed)
//                                .font(.largeTitle)
//                                .fontWeight(.black)
//                            Text("FILM")
//                                .kerning(3) // mejdu kajdim iz bukv budet 3punkta
//                                .font(.subheadline)
//                                .fontWeight(.semibold)
//                                .foregroundStyle(.netflixWhite)
//                        }
//                    }
//                    
//                    Text(title)
//                        .font(.system(size: 50, weight: .medium, design: .serif))
//                }
                //MARK: - Categories
                categoriesSection
//                HStack(spacing: 8) {
//                    ForEach(categories, id: \.self) { category in
//                        Text(category)
//                            .font(.callout)
//                        if category != categories.last {
//                            Circle()
//                                .frame(width: 4, height: 4)
//                        }
//                    }
//                }
                //MARK: - Buttons
                buttonsSection
//                HStack(spacing: 16) {
//                    //1
//                    HStack {
//                        Image(systemName: "play.fill")
//                        Text("Play")
//                    }
//                    .frame(maxWidth: .infinity)
//                    .padding(.vertical, 8)
//                    .foregroundColor(.netflixDarkGray)
//                    .background(.netflixWhite)
//                    .cornerRadius(4)
//                    .asButton(.press) {
//                        onPlayPressed?()
//                    }
//                    //2
//                    HStack {
//                        Image(systemName: "plus")
//                        Text("My List")
//                    }
//                    .frame(maxWidth: .infinity)
//                    .padding(.vertical, 8)
//                    .foregroundColor(.netflixWhite)
//                    .background(.netflixDarkGray)
//                    .cornerRadius(4)
//                    .asButton(.press) {
//                        onMyListPressed?()
//                    }
//                }
//                .font(.callout)
//                .fontWeight(.medium)
            }
            .padding(24)
            .background(
                LinearGradient(
                    colors: [
                        .netflixBlack.opacity(0),
                        .netflixBlack.opacity(0.4),
                        .netflixBlack.opacity(0.4),
                        .netflixBlack.opacity(0.4),
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
        .foregroundStyle(.netflixWhite)
        .cornerRadius(10)
        .aspectRatio(0.8, contentMode: .fit)
        .asButton(.tap) {
            onBackgroundPressed?()
        }
    }
}

#Preview {
    NetflixHeroCell()
        .padding(40)
}

//MARK: - View
extension NetflixHeroCell {
    private var headerSection: some View {
        VStack(spacing: 0) {
            if isNetflixFilm {
                HStack(spacing: 8.0) {
                    Text("N")
                        .foregroundStyle(.netflixRed)
                        .font(.largeTitle)
                        .fontWeight(.black)
                    Text("FILM")
                        .kerning(3) // mejdu kajdim iz bukv budet 3punkta
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.netflixWhite)
                }
            }
            
            Text(title)
                .font(.system(size: 50, weight: .medium, design: .serif))
        }
    }
    private var categoriesSection: some View {
        HStack(spacing: 8) {
            ForEach(categories, id: \.self) { category in
                Text(category)
                    .font(.callout)
                if category != categories.last {
                    Circle()
                        .frame(width: 4, height: 4)
                }
            }
        }
    }
    private var buttonsSection: some View {
        HStack(spacing: 16) {
            //1
            HStack {
                Image(systemName: "play.fill")
                Text("Play")
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .foregroundColor(.netflixDarkGray)
            .background(.netflixWhite)
            .cornerRadius(4)
            .asButton(.press) {
                onPlayPressed?()
            }
            //2
            HStack {
                Image(systemName: "plus")
                Text("My List")
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .foregroundColor(.netflixWhite)
            .background(.netflixDarkGray)
            .cornerRadius(4)
            .asButton(.press) {
                onMyListPressed?()
            }
        }
        .font(.callout)
        .fontWeight(.medium)
    }
}
