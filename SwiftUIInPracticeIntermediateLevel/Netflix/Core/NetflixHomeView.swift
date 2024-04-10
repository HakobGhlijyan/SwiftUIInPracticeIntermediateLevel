//
//  NetflixHomeView.swift
//  SwiftUIInPracticeIntermediateLevel
//
//  Created by Hakob Ghlijyan on 10.04.2024.
//

import SwiftUI

struct NetflixHomeView: View {
    @State private var filters = FilterModel.mockArray
    @State private var selectedFilter: FilterModel? = nil
    
    var body: some View {
        ZStack {
            //0
            Color.netflixBlack.ignoresSafeArea()
            //1
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

                
                Spacer()
            }
        }
        .foregroundStyle(.netflixWhite)
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
