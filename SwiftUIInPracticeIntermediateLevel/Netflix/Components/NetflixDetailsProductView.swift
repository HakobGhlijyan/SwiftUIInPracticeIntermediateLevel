//
//  NetflixDetailsProductView.swift
//  SwiftUIInPracticeIntermediateLevel
//
//  Created by Hakob Ghlijyan on 26.04.2024.
//

import SwiftUI

struct NetflixDetailsProductView: View {
    var title: String = "Movie Title"
    var isNew: Bool = true
    var yearReleased: String? = "2024"
    var seasonCount: Int? = 2
    var hasClosedCaptions: Bool = true
    var isTopTen: Int? = 6
    var descriptionText: String? = "This is the descriptionfor the title that is selected and it should go multiple lines."
    var castText: String? = "Cast: Hakob, Your Name, Someone Else"
    var onPlayPressed: (() -> Void)? = nil
    var onDownloadPressed: (() -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            //1
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            //2
            HStack(spacing: 8) {
                if isNew {
                    Text("New")
                        .foregroundStyle(.green)
                }
                if let yearReleased {
                    Text(yearReleased)
                }
                
                if let seasonCount {
                    Text("\(seasonCount) Seasons")
                }
                
                if hasClosedCaptions {
                    Image(systemName: "captions.bubble")
                }
            }
            .foregroundStyle(.netflixLightGray)
            
            //3
            if let isTopTen {
                HStack(spacing: 8) {
                    topTenIcon
                    Text("#\(isTopTen) in TV Show Today")
                        .font(.headline)
                }
            }
            //4
            VStack(spacing: 8) {
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
                    Image(systemName: "arrow.down.to.line.alt")
                    Text("Download")
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .foregroundColor(.netflixWhite)
                .background(.netflixDarkGray)
                .cornerRadius(4)
                .asButton(.press) {
                    onDownloadPressed?()
                }
            }
            .font(.callout)
            .fontWeight(.medium)
            
            Group {
                //5
                if let descriptionText {
                    Text(descriptionText)
                }
                
                //6
                if let castText {
                    Text(castText)
                        .foregroundStyle(.netflixLightGray)

                }
            }
            .font(.callout)
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
            
        }
        .foregroundStyle(.netflixWhite)
    }
}

#Preview {
    ZStack {
        Color.netflixBlack.ignoresSafeArea()
        VStack(spacing: 40.0) {
            NetflixDetailsProductView()
            NetflixDetailsProductView(
                isNew: false,
                yearReleased: nil,
                seasonCount: nil,
                hasClosedCaptions: false,
                isTopTen: nil,
                descriptionText: nil,
                castText: nil
            )
        }
    }
}

extension NetflixDetailsProductView {
    private var topTenIcon: some View {
        Rectangle()
            .fill(.netflixRed)
            .frame(width: 28, height: 28)
            .overlay {
                VStack(spacing: -4) {
                    Text("TOP")
                        .bold()
                        .font(.system(size: 8))
                    Text("10")
                        .bold()
                        .font(.system(size: 16))
                }
                .offset(y: 1)
            }
    }
}
