//
//  SpotifyPlaylistView.swift
//  SwiftUIInPracticeIntermediateLevel
//
//  Created by Hakob Ghlijyan on 01.04.2024.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct SpotifyPlaylistView: View {
    var product: Product = Product.mock
    var user: User = .mock
    @State private var products: [Product] = []
    @State private var showHeader: Bool = false
    
    @Environment(\.router) var router

    var body: some View {
        ZStack {
            //1
            Color.spotifyBlack.ignoresSafeArea()
            
            //2
            ScrollView(.vertical) {
                LazyVStack(spacing: 12) {
                    //1
                    PlaylistHeaderCell(
                        height: 250,
                        title: product.title,
                        subTitle: product.description,
                        imageName: product.thumbnail
                    )
                    .readingFrame { frame in
                        showHeader = frame.maxY < 150 ? true : false
                    }
                    //2
                    PlaylistDescriptionCell(
                        descriptionText: product.description,
                        userName: user.firstName,
                        subheadline: product.category,
                        onAddToPlaylistPressed: nil,
                        onDownloadPressed: nil,
                        onSharePressed: nil,
                        onEllipsisPressed: nil,
                        onShufflePressed: nil,
                        onPlayPressed: nil
                    )
                    .padding(.horizontal, 16)
                    //3
                    ForEach(products) { product in
                        SongRowCell(
                            imageSize: 50,
                            imageName: product.firstImage,
                            title: product.title,
                            subtitle: product.brand,
                            onCellPressed: {
                                goToPlaylistView(product: product)
                            },
                            onEllipsisPressed: nil
                        )
                        .padding(.leading, 16)
                    }
                }
            }
            .scrollIndicators(.hidden)
            
            //3 Titlec-> budet menyatsya kogda spisok pojdet ma verx
            header
            .frame(maxHeight: .infinity, alignment: .top)
            
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
}

#Preview {
    RouterView { _ in
        SpotifyPlaylistView()
    }
}

extension SpotifyPlaylistView {
    private var header: some View {
        ZStack {
            Text(product.title)
                .font(.headline)
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .background(.spotifyBlack)
                .offset(y: showHeader ? 0 : -40)
                .opacity(showHeader ? 1 : 0)
            
            Image(systemName: "chevron.left")
                .font(.title3)
                .padding(10)
                .background(showHeader ? .black.opacity(0) : .spotifyGray.opacity(0.7) )
                .clipShape(Circle())
                .onTapGesture {
                    router.dismissScreen()
                }
                .padding(.leading, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .foregroundStyle(.spotifyWhite)
        .animation(.smooth(duration: 0.2), value: showHeader)
    }
    
    private func getData() async {
        do {
            products = try await DatabaseHelper().getProducts()
        } catch {
            
        }
    }
    
    func goToPlaylistView(product: Product) {
        router.showScreen(.push) { _ in
            SpotifyPlaylistView(product: product, user: user)
        }
    }
    
}
