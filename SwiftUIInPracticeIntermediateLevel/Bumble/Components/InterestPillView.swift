//
//  InterestPillView.swift
//  SwiftUIInPracticeIntermediateLevel
//
//  Created by Hakob Ghlijyan on 03.04.2024.
//

import SwiftUI

struct InterestPillView: View {
    
    var iconName: String? = "heart.fill"
    var emoji: String? = "😍"
    var text: String = "Gradiate Degree"
    
    var body: some View {
        HStack(spacing: 4.0) {
            if let iconName {
                Image(systemName: iconName)
            } else if let emoji {
                Text(emoji)
            }
            Text(text)
        }
        .font(.callout)
        .fontWeight(.medium)
        .padding(.vertical, 6)
        .padding(.horizontal, 12)
        .foregroundStyle(.bumbleBlack)
        .background(.bumbleLightYellow)
        .cornerRadius(32)
    }
}

#Preview {
    VStack(spacing: 20.0) {
        InterestPillView(iconName: "heart.fill", emoji: nil, text: "First Degree")
        InterestPillView(iconName: nil, emoji: "😍", text: "Second Degree")
        InterestPillView(iconName: nil, emoji: "😍", text: "Degree")
    }
}
