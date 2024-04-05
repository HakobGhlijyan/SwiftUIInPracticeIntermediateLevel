//
//  BumbleHomeView.swift
//  SwiftUIInPracticeIntermediateLevel
//
//  Created by Hakob Ghlijyan on 03.04.2024.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct BumbleHomeView: View {
    @Environment(\.router) var router
    
    @State private var filters: [String] = ["Everyone", "Trending"]
    @AppStorage("bumble_home_filter") private var selectedFilter: String = "Everyone"
    @State private var allUser:[User] = []
    @State private var selectedIndex: Int = 0
    @State private var cardOffsets: [Int:Bool] = [:]
    @State private var currentSwipeOffset: CGFloat = 0

    
    var body: some View {
        ZStack {
            //1
            Color.bumbleWhite.ignoresSafeArea()
            //2
            VStack(spacing: 12) {
                header
                BumbleFilterView(options: filters, selection: $selectedFilter)
                    .background(Divider(), alignment: .bottom)
                
                ZStack {
                    if !allUser.isEmpty {
                        ForEach(Array(allUser.enumerated()), id: \.offset) { (index , user) in
                            let isPrevious = (selectedIndex - 1) == index
                            let isCurrent = selectedIndex == index
                            let isNext = (selectedIndex + 1) == index
                            
                            if isPrevious || isCurrent || isNext {
                                let offsetValue = cardOffsets[user.id]
                                userProfileCell(user: user, index: index)
                                    .zIndex(Double(allUser.count - index))
                                    .offset(x: offsetValue == nil ? 0 : offsetValue == true ? 900 : -900)
                            }
                        }
                    } else {
                        ProgressView()
                    }
                    overlaySwipingIndicator
                        .zIndex(9999999)
                }
                .frame(maxHeight: .infinity)
                .padding(4)
                .animation(.smooth, value: cardOffsets)
            }
            .padding(8)
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    RouterView { _ in
        BumbleHomeView()
    }
}

extension BumbleHomeView {
    private var header: some View {
        HStack(spacing: 0.0) {
            //1
            HStack(spacing: 0.0) {
                Image(systemName: "line.horizontal.3")
                    .padding(8)
                    .background(.black.opacity(0))
                    .onTapGesture { 

                    }
                Image(systemName: "arrow.uturn.left")
                    .padding(8)
                    .background(.black.opacity(0))
                    .onTapGesture {   
                        router.dismissScreen()
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            //2
            Text("bumble")
                .font(.title)
                .foregroundStyle(.bumbleYellow)
                .frame(maxWidth: .infinity, alignment: .center)
            //3
            Image(systemName: "message.badge.waveform.fill")   //"slider.horizontal.3"
                .padding(8)
                .background(.black.opacity(0))
                .onTapGesture {  
                    router.showScreen(.push) { _ in
                        BumbleChatsView()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .font(.title2)
        .fontWeight(.medium)
        .foregroundStyle(.bumbleBlack)
    }
    private func userProfileCell(user: User, index: Int) -> some View {
        BumbleCardView(
            user: user,
            onSendAComplimentPresed: nil,
            onSuperLikePresed: nil,
            onXmarkLikePresed: {
                userDidSelect(index: index, isLike: false)
            },
            onCheckmarkPresed: {
                userDidSelect(index: index, isLike: true)
            },
            onHideAndRaportPresed: nil
        )
        .withDragGesture(
            .horizontal,
            minimumDistance: 20,
            resets: true,
            rotationMultiplier: 1.05,
            onChanged: { dragOffset in
                currentSwipeOffset = dragOffset.width
            },
            onEnded: { dragOffset in
                if dragOffset.width < -50 {
                    userDidSelect(index: index, isLike: false)
                } else if dragOffset.width > 50 {
                    userDidSelect(index: index, isLike: true)
                }
            }
        )
    }
    
    private var overlaySwipingIndicator: some View {
        ZStack {
            Circle()
                .fill(.bumbleGray.opacity(0.4))
                .overlay(
                Image(systemName: "xmark")
                    .font(.title)
                    .fontWeight(.semibold)
                )
                .frame(width: 60, height: 60)
                .scaleEffect(abs(currentSwipeOffset) > 100 ? 1.5 : 1)
                .offset(x: min(-currentSwipeOffset, 150))
                .offset(x: -100)
                .frame(maxWidth: .infinity, alignment: .leading)
            Circle()
                .fill(.bumbleGray.opacity(0.4))
                .overlay(
                Image(systemName: "checkmark")
                    .font(.title)
                    .fontWeight(.semibold)
                )
                .frame(width: 60, height: 60)
                .scaleEffect(abs(currentSwipeOffset) > 100 ? 1.5 : 1)
                .offset(x: max(-currentSwipeOffset, -150))
                .offset(x: 100)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .animation(.smooth, value: currentSwipeOffset)
    }
}

extension BumbleHomeView {
    private func getData() async {
        guard allUser.isEmpty else { return }
        do {
            allUser = try await DatabaseHelper().getUsers()
        } catch {
            print(error)
        }
    }
    
    private func userDidSelect(index: Int, isLike: Bool) {
        let user = allUser[index]
        cardOffsets[user.id] = isLike
        selectedIndex += 1
    }
}
