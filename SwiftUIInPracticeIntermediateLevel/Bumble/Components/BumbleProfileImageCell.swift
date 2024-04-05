//
//  BumbleProfileImageCell.swift
//  SwiftUIInPracticeIntermediateLevel
//
//  Created by Hakob Ghlijyan on 05.04.2024.
//

import SwiftUI

struct BumbleProfileImageCell: View {
    var imageName:String = Constants.randomImage
    var percentageRemaining: Double = Double.random(in: 0...1)
    var hasNewMessage: Bool = true
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(.bumbleGray, lineWidth: 2)
            Circle()
                .trim(from: 0, to: percentageRemaining)
                .stroke(.bumbleYellow, lineWidth: 4)
                .rotationEffect(.degrees(-90))
                .scaleEffect(x: -1, y: 1, anchor: .center)
            
            ImageLoaderView(urlString: imageName)
                .clipShape(Circle())
                .padding(5)
        }
        .frame(width: 75, height: 75)
        .overlay(
            ZStack {
                if hasNewMessage {
                    Circle()
                        .fill(.bumbleWhite)
                    Circle()
                        .fill(.bumbleYellow)
                        .padding(4)
                }
            }
                .offset(x: 2, y: 2)
                .frame(width: 24, height: 24)
            , alignment: .bottomTrailing
        )
    }
}

#Preview {
    VStack {
        BumbleProfileImageCell()
        BumbleProfileImageCell(percentageRemaining: 0.5)
        BumbleProfileImageCell(percentageRemaining: 0)
        BumbleProfileImageCell(hasNewMessage: false)
    }
    .scaleEffect(2)
}
