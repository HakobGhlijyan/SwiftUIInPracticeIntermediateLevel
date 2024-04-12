//
//  NetflixHomeView.swift
//  SwiftUIInPracticeIntermediateLevel
//
//  Created by Hakob Ghlijyan on 10.04.2024.
//

import SwiftUI
import SwiftfulUI

struct NetflixHomeView: View {
    @State private var filters = FilterModel.mockArray
    @State private var selectedFilter: FilterModel? = nil
    @State private var fullHeaderSize: CGSize = .zero
    @State private var heroProduct: Product? = nil
    @State private var currentUser: User? = nil
    @State private var productRows: [ProductRow] = []
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.netflixBlack.ignoresSafeArea()
            
            ScrollView(.vertical) {
                VStack(spacing: 8.0) {
                    Rectangle()
                        .opacity(0)
                        .frame(height: fullHeaderSize.height)
                    
                    if let heroProduct {
                        heroCell(heroProduct)
                    }
                    categoriesRows
                }
            }
            .scrollIndicators(.hidden)

            VStack(spacing: 0.0) {
                header
                    .padding(.horizontal, 16)
                NetflixFilterBarView(
                    filters: filters,
                    selectedFilter: selectedFilter,
                    onFilterPressed: { newFilter in
                        selectedFilter = newFilter
                    },
                    onXMarkPressed: {
                        selectedFilter = nil
                    }
                )
                .padding(.top, 16)
            }
            .background(.blue)
            .readingFrame { frame in
                fullHeaderSize = frame.size
            }
        }
        .foregroundStyle(.netflixWhite)
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    NetflixHomeView()
}

//MARK: - VIEW
extension NetflixHomeView {
    private var header: some View {
        HStack(spacing: 0.0) {
            Text("For You")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
        
            HStack(spacing: 16.0) {
                Image(systemName: "tv.badge.wifi")
                    .onTapGesture {
                        //
                    }
                Image(systemName: "magnifyingglass")
                    .onTapGesture {
                        //
                    }
            }
            .font(.title2)
        }
    }
    
    private func heroCell(_ heroProduct: Product) -> some View {
        NetflixHeroCell(
            imageName: heroProduct.firstImage,
            isNetflixFilm: true,
            title: heroProduct.title,
            categories: [heroProduct.category.capitalized, heroProduct.brand],
            onBackgroundPressed: {
                
            },
            onPlayPressed: {
                
            },
            onMyListPressed: {
                
            }
        )
        .padding(24)
    }
    
    private var categoriesRows: some View {
        LazyVStack(spacing: 16) {
            ForEach(Array(productRows.enumerated()), id: \.offset) { (rowIndex, row) in
                VStack(alignment: .leading, spacing: 6) {
                    Text(row.title)
                        .font(.headline)
                        .padding(.horizontal, 16)
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(Array(row.products.enumerated()), id:\.offset) { (index, product) in
                                NetflixMovieCell(
                                    imageName: product.firstImage,
                                    title: product.title,
                                    isRecentlyAdded: product.recentlyAdded,
                                    topTeRanking: rowIndex == 1 ? (index + 1) : nil
                                    //esli row index budet vtoraya , to u nix budet rating
                                )
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    .scrollIndicators(.hidden)
                }
            }
        }
    }
}

extension NetflixHomeView {
    private func getData() async {
        guard productRows.isEmpty else { return }
        do {
            currentUser = try await DatabaseHelper().getUsers().first
//            let products = try await DatabaseHelper().getProducts()
            let products = try await Array(DatabaseHelper().getProducts().prefix(7))
            heroProduct = products.first
            
            var rows: [ProductRow] = []
            let allBrands = Set(products.map { $0.brand })
            for brand in allBrands {
                rows.append(ProductRow(title: brand.capitalized, products: products))
            }
            productRows = rows
        } catch {
            
        }
    }
    
}
