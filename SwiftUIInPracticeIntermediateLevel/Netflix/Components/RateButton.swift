//
//  RateButton.swift
//  SwiftUIInPracticeIntermediateLevel
//
//  Created by Hakob Ghlijyan on 26.04.2024.
//

import SwiftUI

enum RateOption: String, CaseIterable {
    case dislike, like, love
    
    var title: String {
        switch self {
        case .dislike:
            "Not for Me"
        case .like:
            "I like this!"
        case .love:
            "Love this!!"
        }
    }
    
    var image: String {
        switch self {
        case .dislike:
            "hand.thumbsdown"
        case .like:
            "hand.thumbsup"
        case .love:
            "bolt.heart"
        }
    }
}

struct RateButton: View {
    @State private var showPopover: Bool = false
    
    var body: some View {
        VStack(spacing: 8.0) {
            Image(systemName: "hand.thumbsup")
                .font(.title)
            
            Text("Rate")
                .font(.caption)
                .foregroundStyle(.netflixLightGray)
        }
        .foregroundStyle(.netflixWhite)
        .padding(8)
        .background(.black.opacity(0.001))
        .onTapGesture {
            showPopover.toggle()
        }
        .popover(isPresented: $showPopover) {
            ZStack {
                Color.netflixDarkGray.ignoresSafeArea()
                   
//                HStack(spacing: 12) {
//                    rateButton(option: .dislike)
//                    rateButton(option: .like)
//                    rateButton(option: .love)
//                }
                // VMESTO NEGO ForEach
//                ForEach(
                
            }
            .presentationCompactAdaptation(.popover)
        }
    }
        
    @ViewBuilder
    private func rateButton(option: RateOption) -> some View {
        VStack(spacing: 8) {
            Image(systemName: option.image)
                .font(.title2)
            
            Text(option.title)
                .font(.caption)
            
        }
        .foregroundStyle(.netflixWhite)
        .padding(4)
        .background(.black.opacity(0.0001))
        .onTapGesture {
            
        }
    }
    
}

#Preview {
    ZStack {
        Color.netflixBlack.ignoresSafeArea()
        RateButton()
    }
}


//14.28
