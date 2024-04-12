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
    //Product
    @State private var heroProduct: Product? = nil
    @State private var currentUser: User? = nil
    @State private var productRows: [ProductRow] = []
    
    var body: some View {
        ZStack(alignment: .top) {
            //0
            Color.netflixBlack.ignoresSafeArea()
            
            //1
            ScrollView(.vertical) {
                VStack(spacing: 8.0) {
                    //0 CEll Hiden
                    Rectangle()
                        .opacity(0)
                        .frame(height: fullHeaderSize.height)
                    
                    //1 Cell
//                    NetflixHeroCell() 
                    // vmesto nego nash poluchaemiy product zaglavnaya chast
                    // NO SDEZ U NAS NET DANIX ... SDELAEM FUNC GETDATA
                    //1
                    if let heroProduct {
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
                    
                    ForEach(0..<5) { _ in
                        Rectangle()
                            .fill(.red)
                            .frame(height: 200)
                    }
                }
            }
            .scrollIndicators(.hidden)
            
            //2
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
}

extension NetflixHomeView {
    private func getData() async {
        guard productRows.isEmpty else { return }
        do {
            currentUser = try await DatabaseHelper().getUsers().first
            let products = try await DatabaseHelper().getProducts()
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
