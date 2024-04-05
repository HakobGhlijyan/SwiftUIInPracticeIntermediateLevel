//
//  BumbleChatsView.swift
//  SwiftUIInPracticeIntermediateLevel
//
//  Created by Hakob Ghlijyan on 05.04.2024.
//

import SwiftUI
import SwiftfulRouting

struct BumbleChatsView: View {
    @Environment(\.router) var router
    @State private var allUser:[User] = []
    
    var body: some View {
        ZStack {
            Color.bumbleWhite.ignoresSafeArea()
            
            VStack(spacing: 0.0) {
                header
                    .padding(16)
                matchQueueSection
                    .padding(.vertical, 16)
                recentChatsSection
            }
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    BumbleChatsView()
}
//View
extension BumbleChatsView {
    private var header: some View {
        HStack(spacing: 0.0) {
            Image(systemName: "arrow.uturn.left")  //"line.horizontal.3"
                .onTapGesture {
                    router.dismissScreen()
                }
            Spacer(minLength: 0)
            Image(systemName: "magnifyingglass")
        }
        .font(.title)
        .fontWeight(.medium)
    }
    
    private var matchQueueSection: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Group {
                Text("Match Queue")
                    .font(.headline)
                +
                Text(" (\(allUser.count))")
                    .foregroundStyle(.bumbleGray)
            }
            .padding(.horizontal, 16)
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 16) {
                    ForEach(allUser) { user in
                        BumbleProfileImageCell(
                            imageName: user.images.randomElement()!,
                            percentageRemaining: Double.random(in: 0...1),
                            hasNewMessage: Bool.random()
                        )
                    }
                }
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
            .frame(height: 100)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var recentChatsSection: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            HStack {
                Group {
                    Text("Chats")
                        .font(.headline)
                    +
                    Text(" (Recent)")
                        .foregroundStyle(.bumbleGray)
                }
                Spacer(minLength: 0)
                Image(systemName: "line.horizontal.3.decrease")
                    .font(.title2)

            }
            .padding(.horizontal, 16)
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 16) {
                    ForEach(allUser) { user in
                        BumbleChatPreviewCell(
                            userName: user.firstName,
                            lastChatMessage: user.aboutMe,
                            isYourMove: Bool.random(),
                            imageName: user.images.randomElement()!,
                            percentageRemaining: Double.random(in: 0...1),
                            hasNewMessage: Bool.random()
                        )
                    }
                }
                .padding(16)
            }
            .scrollIndicators(.hidden)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
//Func
extension BumbleChatsView {
    private func getData() async {
        guard allUser.isEmpty else { return }
        do {
            allUser = try await DatabaseHelper().getUsers()
        } catch {
            print(error)
        }
    }
}
