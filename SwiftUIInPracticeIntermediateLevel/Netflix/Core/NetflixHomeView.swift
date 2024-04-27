//
//  NetflixHomeView.swift
//  SwiftUIInPracticeIntermediateLevel
//
//  Created by Hakob Ghlijyan on 10.04.2024.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct NetflixHomeView: View {
    @Environment(\.router) var router
    @State private var filters = FilterModel.mockArray
    @State private var selectedFilter: FilterModel? = nil
    @State private var fullHeaderSize: CGSize = .zero
    @State private var scrollViewOffset: CGFloat = 0
    @State private var heroProduct: Product? = nil
    @State private var currentUser: User? = nil
    @State private var productRows: [ProductRow] = []
    
    var body: some View {
        ZStack(alignment: .top) {
            //0.1
            Color.netflixBlack.ignoresSafeArea()
            //0.2
            backgroundGradientLayer
            //1
            scrollViewLayer
            //2
            fullHeaderWithFilter
        }
        .foregroundStyle(.netflixWhite)
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    RouterView { _ in
        NetflixHomeView()
    }
}

//MARK: - VIEW
extension NetflixHomeView {
    private var header: some View {
        HStack(spacing: 0.0) {
            Text("For You")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .onTapGesture {
                    router.dismissScreen()
                }
        
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
    
    private var fullHeaderWithFilter: some View {
        VStack(spacing: 0.0) {
            header
                .padding(.horizontal, 16)
            
            if scrollViewOffset > -20 {    // esli znachenie budet bolche 20 to filtri udalyatsya.
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
                .transition(.move(edge: .top).combined(with: .opacity))
                // i skombiniruem s opasiti
                // dlay perexoda mi dobavim transition.... i animation v ves vstack
            }
            
        }
        //dobavim nemnogo otstupa
        .padding(.bottom, 8)
        .background(  //sdelaem tak esli budet -70 to tam budet rec...
            ZStack {
                if scrollViewOffset < -70 {
                    Rectangle()
                        .fill(.clear)
                        .background(.ultraThinMaterial)
                        .brightness(-0.2)
                        .ignoresSafeArea()
                }
            }
        )
        .animation(.smooth, value: scrollViewOffset)
        .readingFrame { frame in
            if scrollViewOffset == .zero {
                fullHeaderSize = frame.size
            }
        }
    }
    
    private var backgroundGradientLayer: some View {
        ZStack {
            LinearGradient(colors: [.netflixDarkGray.opacity(1), .netflixDarkGray.opacity(0)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            LinearGradient(colors: [.netflixDarkRed.opacity(0.5), .netflixDarkRed.opacity(0)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        }
        .frame(maxHeight: max(10, 400 + (scrollViewOffset * 0.75)))
        .opacity(scrollViewOffset < -250 ? 0 : 1)
        .animation(.easeInOut, value: scrollViewOffset)
        
//            .frame(maxHeight: 400 + (scrollViewOffset * 0.75))
        // on i vniz poydet ... nam nujno tolko chtob bilo verx... max(...)
//            .frame(maxHeight: 400)
        // etot gradient toje doljen podnimatsya na verx pri smechenii. potomu dobavim + scrollViewOffset
    }
    
    private var scrollViewLayer: some View {
        ScrollViewWithOnScrollChanged(
            .vertical,
            showsIndicators: false) {
                VStack(spacing: 8.0) {
                    Rectangle()
                        .opacity(0)
                        .frame(height: fullHeaderSize.height)
                    
                    if let heroProduct {
                        heroCell(heroProduct)
                    }
                    
//                    Text("\(scrollViewOffset)")  // tut budet offset na kotoriy podnimitsya ekran pri scroll
                    
                    categoriesRows
                }
            } onScrollChanged: { offset in
//                scrollViewOffset = offset.y // animation fon red pri scroll v niz budet ..
                scrollViewOffset = min(0, offset.y) // animation fon red pri scroll v niz NO ..

            }
    }
    
    private func heroCell(_ heroProduct: Product) -> some View {
        NetflixHeroCell(
            imageName: heroProduct.firstImage,
            isNetflixFilm: true,
            title: heroProduct.title,
            categories: [heroProduct.category.capitalized, heroProduct.brand],
            onBackgroundPressed: {
                //Vizovim dlya perexoda... sheet
                onProductPressed(product: heroProduct)
            },
            onPlayPressed: {
                //Vizovim dlya perexoda... sheet
                onProductPressed(product: heroProduct)
            },
            onMyListPressed: {
                // ignor this time
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
                                .onTapGesture {
                                    onProductPressed(product: product)
                                }
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
                rows.append(ProductRow(title: brand.capitalized, products: products.shuffled()))
            }
            productRows = rows
        } catch {
            
        }
    }
    
    // Universal func for sheet
    private func onProductPressed(product: Product) {
        router.showScreen(.sheet) { _ in
            NetflixMovieDetailsView(product: product)
        }
    }
}
