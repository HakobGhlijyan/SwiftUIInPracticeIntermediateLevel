//
//  NetflifFilterCell.swift
//  SwiftUIInPracticeIntermediateLevel
//
//  Created by Hakob Ghlijyan on 10.04.2024.
//

import SwiftUI

struct NetflifFilterCell: View {
    
    var title: String = "Categories"
    var isDropdown: Bool = true
    var isSelected: Bool = false
    
    var body: some View {
        HStack {
            Text(title)
            
            if isDropdown {
                Image(systemName: "chevron.down")
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(
            ZStack {
                Capsule(style: .circular)           
                    .fill(.netflixDarkGray)
                    .opacity(isSelected ? 1 : 0)
                
                Capsule(style: .circular)
                    .stroke(lineWidth: 1.0)
            }
        )
        .foregroundStyle(.netflixLightGray)
    }
}

#Preview {
    ZStack {
        Color.netflixBlack.ignoresSafeArea()
        
        VStack(spacing: 20.0) {
            NetflifFilterCell()
            NetflifFilterCell(isDropdown: false)
            NetflifFilterCell(isSelected: true)
        }
    }
}
