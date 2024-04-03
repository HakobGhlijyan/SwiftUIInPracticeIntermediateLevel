//
//  BumbleCardView.swift
//  SwiftUIInPracticeIntermediateLevel
//
//  Created by Hakob Ghlijyan on 03.04.2024.
//

import SwiftUI
import SwiftfulUI

struct BumbleCardView: View {
    var user: User = .mock
    @State private var cardFrame: CGRect = .zero
    var onSendAComplimentPresed: (() -> Void)? = nil
    var onSuperLikePresed: (() -> Void)? = nil
    var onXmarkLikePresed: (() -> Void)? = nil
    var onCheckmarkPresed: (() -> Void)? = nil
    var onHideAndRaportPresed: (() -> Void)? = nil
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                //1
                headerCell
                    .frame(height: cardFrame.height)
                //2
                aboutMeSection
                    .padding(.horizontal, 24)
                    .padding(.vertical, 24)
                //3
                myInterestsSection
                    .padding(.horizontal, 24)
                    .padding(.vertical, 24)
                //4
                ForEach(user.images, id: \.self) { image in
                    ImageLoaderView(urlString: image)
                        .frame(height: cardFrame.height)
                }
                //4
                locationSection
                .padding(.horizontal, 24)
                .padding(.vertical, 24)
                //5
                footerSection
                    .padding(.vertical, 60)
                    .padding(.horizontal,32)
            }
        }
        .scrollIndicators(.hidden)
        .background(.bumbleBackgroundYellow)
        .overlay(
            superLikeButton
           , alignment: .bottomTrailing
        )
        .cornerRadius(32)
        .readingFrame { frame in
            cardFrame = frame
        }
    }
}

#Preview {
    BumbleCardView()
        .padding(.vertical, 40)
        .padding(.horizontal, 16)
}
// some View
extension BumbleCardView {
    private var headerCell: some View {
        ZStack(alignment: .bottomLeading) {
            //1
            ImageLoaderView(urlString: user.image)
            //2
            VStack(alignment: .leading, spacing: 8.0) {
                Text("\(user.firstName), \(user.age)")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                HStack(spacing: 4.0) {
                    Image(systemName: "suitcase")
                    Text(user.work)
                }
                HStack(spacing: 4.0) {
                    Image(systemName: "graduationcap")
                    Text(user.education)
                }
                BumbleHeartView()
                    .onTapGesture {
                        //
                    }
            }
            .padding(24)
            .font(.callout)
            .fontWeight(.medium)
            .foregroundStyle(.bumbleWhite)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                LinearGradient(
                    colors: [
                        .bumbleBlack.opacity(0),
                        .bumbleBlack.opacity(0.4),
                        .bumbleBlack.opacity(0.5),
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
    }
    
    private var aboutMeSection: some View {
        VStack(alignment: .leading, spacing: 12.0) {
            sectionTitle(title: "Abount Me")
            
            Text(user.aboutMe)
                .font(.body)
                .fontWeight(.semibold)
                .foregroundStyle(.bumbleBlack)
            
            HStack(spacing: 0) {
                BumbleHeartView()
                Text("Send a Compliment")
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            .padding(.horizontal, 8)
            .padding(.trailing, 8)
            .background(.bumbleYellow)
            .cornerRadius(32)
            .onTapGesture {
                onSendAComplimentPresed?()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var myInterestsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 8) {
                sectionTitle(title: "My Basic")
                InterestPillGridView(interests: user.basics)
            }
            VStack(alignment: .leading, spacing: 8) {
                sectionTitle(title: "My Basic")
                InterestPillGridView(interests: user.interests)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var locationSection: some View {
        VStack(alignment: .leading, spacing: 12.0) {
            HStack(spacing: 8.0) {
                Image(systemName: "mappin.and.ellipse.circle.fill")
                Text(user.firstName + "'s Location")
            }
            .font(.body)
            .foregroundStyle(.bumbleGray)
            .fontWeight(.medium)
            
            Text("3 km away")
                .font(.headline)
                .foregroundStyle(.bumbleBlack)
            
            InterestPillView(iconName: nil, emoji: "🇦🇲", text: "Live in Yerevan")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var footerSection: some View {
        VStack(spacing: 24.0) {
            HStack(spacing: 0.0) {
                //no
                Circle()
                    .fill(.bumbleYellow)
                    .overlay(
                        Image(systemName: "xmark")
                            .font(.title)
                            .fontWeight(.semibold)
                    )
                    .frame(width: 60, height: 60)
                    .onTapGesture {
                        onXmarkLikePresed?()
                    }
                
                Spacer(minLength: 0)
                
                //yes
                Circle()
                    .fill(.bumbleYellow)
                    .overlay(
                        Image(systemName: "checkmark")
                            .font(.title)
                            .fontWeight(.semibold)
                    )
                    .frame(width: 60, height: 60)
                    .onTapGesture {
                        onCheckmarkPresed?()
                    }
            }
            Text("Hide and Raport")
                .font(.headline)
                .foregroundStyle(.bumbleGray)
                .padding(8)
                .background(.black.opacity(0.001))
                .onTapGesture {
                    onHideAndRaportPresed?()
                }
        }
    }
    
    private var superLikeButton: some View {
        Image(systemName: "hexagon.fill")
            .foregroundStyle(.bumbleYellow)
            .font(.system(size: 60))
            .overlay(
                Image(systemName: "star.fill")
                    .foregroundStyle(.bumbleBlack)
                    .font(.system(size: 30, weight: .medium))
            )
            .onTapGesture {
                onSuperLikePresed?()
            }
            .padding(24)
    }
}
// Funcs
extension BumbleCardView {
    private func sectionTitle(title:String) -> some View {
        Text(title)
            .font(.body)
            .foregroundStyle(.bumbleGray)
    }
}
