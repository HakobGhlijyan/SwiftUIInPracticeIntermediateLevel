//
//  MyListButton.swift
//  SwiftUIInPracticeIntermediateLevel
//
//  Created by Hakob Ghlijyan on 26.04.2024.
//

import SwiftUI

struct MyListButton: View {
    var isMyList: Bool = false
    var onButtonPressed: (()-> Void)? = nil
    
    var body: some View {
        VStack(spacing: 8.0) {
            ZStack {
                Image(systemName: "checkmark")
                    .opacity(isMyList ? 1 : 0)
                    .rotationEffect(.degrees(isMyList ? 0 : 180))
                
                Image(systemName: "plus")
                    .opacity(isMyList ? 0 : 1)
                    .rotationEffect(.degrees(isMyList ? -180 : 0))
            }
            .font(.title)
            
            Text("My List")
                .font(.caption)
                .foregroundStyle(.netflixLightGray)
        }
        .foregroundStyle(.netflixWhite)
        .padding(8)
        .background(.black.opacity(0.001))
        .animation(.bouncy, value: isMyList)
        .onTapGesture {
            onButtonPressed?()
        }
        
    }
}

fileprivate struct MyListButtonPreview: View {
    @State private var isMyList: Bool = false
    
    var body: some View {
        MyListButton(isMyList: isMyList) {
            isMyList.toggle()
        }
    }
}

#Preview {
    ZStack {
        Color.netflixBlack.ignoresSafeArea()
        MyListButtonPreview()
    }
    .scaleEffect(2)
}
