//
//  SpotifyHomeView.swift
//  SwiftUIInPracticeIntermediateLevel
//
//  Created by Hakob Ghlijyan on 30.03.2024.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct SpotifyHomeView: View {
    // IN MVVM
//    @State var viewModel: SpotifyHomeViewModel
    //NO MVVM
    @State private var currentUser: User? = nil
    @State private var selectedCategory: Category? = nil
    @State private var products: [Product] = []
    @State private var productRows: [ProductRow] = []
    @Environment(\.router) var router
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            ScrollView {
                LazyVStack(spacing: 2, pinnedViews: [.sectionHeaders], content: {
                    Section {
                        VStack(spacing: 16.0) {
                            recentsSection
                                .padding(.horizontal, 16)
                            
                            if let product = products.first {
                                newReleaseSection(product: product)
                                    .padding(.horizontal, 16)
                            }
                            
                            listRow
                        }
                    } header: {
                        headerSection
                    }
                })
                .padding(.top, 8)
            }
            .scrollIndicators(.hidden)
            .clipped()
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
}

#Preview {
    //1 no MVVM
    RouterView { _ in
        SpotifyHomeView()
    }
    //2. IN MVVM
//    RouterView { router in
//        SpotifyHomeView(viewModel: SpotifyHomeViewModel(router: router))
//    }
}

// Compnents Layer fo View
extension SpotifyHomeView {
    //1
    private var headerSection: some View {
        HStack(spacing: 0.0) {
            ZStack {
                if let currentUser {
                    ImageLoaderView(urlString: currentUser.image)
                        .background(.spotifyWhite)
                        .clipShape(Circle())
                        .onTapGesture {
                            //najav na icon avatar mi viydem iz nego
                            router.dismissScreen()
                        }
                }
            }
            .frame(width: 35, height: 35)
            
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    ForEach(Category.allCases, id: \.self) { category in
                        SpotifyCategoryCell(
                            title: category.rawValue.capitalized,
                            isSelected: category == selectedCategory
                        )
                        .onTapGesture {
                            selectedCategory = category
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
        }
        .padding(.vertical, 24)
        .padding(.leading, 8)
        .background(.spotifyBlack)
    }
    //2
    private var recentsSection: some View {
        NonLazyVGrid(columns: 2, alignment: .center, spacing: 10, items: products) { product in
            if let product {
                SpotifyRecentsCell(
                    imageName: product.firstImage,
                    title: product.title
                )
                .asButton(.press) {
                    //
                    goToPlaylistView(product: product)
                }
            }
        }
    }
    //3
    private func newReleaseSection(product: Product) -> some View {
        SpotifyNewReleaseCell(
            imageName: product.firstImage,
            headline: product.brand,
            subheadline: product.category,
            title: product.title,
            subtitle: product.description,
            onAddToPlaylistPressed: nil,
            onPlayPressed: {
                goToPlaylistView(product: product)
            }
        )
    }
    //4
    private var listRow: some View {
        ForEach(productRows) { row in
            VStack(spacing: 8.0) {
                Text(row.title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.spotifyWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                
                ScrollView(.horizontal) {
                    HStack(alignment: .top, spacing: 16.0) {
                        ForEach(row.products) { product in
                            ImageTitleRowCell(
                                imageSize: 120,
                                imageName: product.firstImage,
                                title: product.title
                            )
                            .asButton(.press) {
                                //
                                goToPlaylistView(product: product)
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

// Func For Get Data -> NO MVVM
extension SpotifyHomeView {
    
//     Tak on budet kajdiy raz zagrujat .. v ovom dobavim proverku na isEmpty...
//    private func getData() async {
//        do {
//            currentUser = try await DatabaseHelper().getUsers().first
//            products = try await Array(DatabaseHelper().getProducts().prefix(8))
//            
//            var rows: [ProductRow] = []
//            let allBrands = Set(products.map { $0.brand })
//            for brand in allBrands {
//                rows.append(ProductRow(title: brand.capitalized, products: products))
//            }
//            productRows = rows
//        } catch {
//            
//        }
//    }
    
    private func getData() async {
        guard products.isEmpty else { return }
        do {
            currentUser = try await DatabaseHelper().getUsers().first
            products = try await Array(DatabaseHelper().getProducts().prefix(8))
            
            var rows: [ProductRow] = []
            let allBrands = Set(products.map { $0.brand })
            for brand in allBrands {
                rows.append(ProductRow(title: brand.capitalized, products: products))
            }
            productRows = rows
        } catch {
            
        }
    }
    
    func goToPlaylistView(product: Product) {
        guard let currentUser else {
            return
        }
        router.showScreen(.push) { _ in
            SpotifyPlaylistView(product: product, user: currentUser)
        }
    }
}

/*
 
 @Observable    // Tak bi mi smogli vse perestoyt po takomu principu <MVVM>
 final class SpotifyHomeViewModel {
     let router:AnyRouter
     
     var currentUser: User? = nil
     var selectedCategory: Category? = nil
     var products: [Product] = []
     var productRows: [ProductRow] = []
     
     init(router: AnyRouter) {
         self.router = router
         self.currentUser = currentUser
         self.selectedCategory = selectedCategory
         self.products = products
         self.productRows = productRows
     }
     
     func getData() async {
         guard products.isEmpty else { return }
         do {
             currentUser = try await DatabaseHelper().getUsers().first
             products = try await Array(DatabaseHelper().getProducts().prefix(8))
             
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
 
 */
