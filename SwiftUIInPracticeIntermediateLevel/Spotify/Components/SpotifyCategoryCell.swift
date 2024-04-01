//
//  SpotifyCategoryCell.swift
//  SwiftUIInPracticeIntermediateLevel
//
//  Created by Hakob Ghlijyan on 30.03.2024.
//

import SwiftUI

struct SpotifyCategoryCell: View {
    var title:String = "Music"
    var isSelected: Bool = false
    
    var body: some View {
        Text(title)
            .font(.callout)
            .frame(minWidth: 35)
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .themeColor(isSelected: isSelected)
            .cornerRadius(16)
    }
}

extension View {
    func themeColor(isSelected: Bool) -> some View {
        self
            .foregroundStyle(isSelected ? .spotifyBlack : .spotifyWhite)
            .background(isSelected ? .spotifyGreen : .spotifyDarkGray)
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        
        VStack(spacing: 40) {
            SpotifyCategoryCell(title: "Title goes here")
            SpotifyCategoryCell(title: "Title goes here", isSelected: true)
            SpotifyCategoryCell(title: "All", isSelected: true)
        }
    }
}
