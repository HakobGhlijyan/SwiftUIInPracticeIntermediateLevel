//
//  BumbleHomeView.swift
//  SwiftUIInPracticeIntermediateLevel
//
//  Created by Hakob Ghlijyan on 03.04.2024.
//

import SwiftUI

struct BumbleHomeView: View {
    
    @State private var filters: [String] = ["Everyone", "Trending"]
    @AppStorage("bumble_home_filter") private var selectedFilter: String = "Everyone"

    var body: some View {
        ZStack {
            //1
            Color.bumbleWhite.ignoresSafeArea()
            
            //2
            VStack(spacing: 12) {
                header
                BumbleFilterView(options: filters, selection: $selectedFilter)
                    .background(Divider(), alignment: .bottom)
                
                Spacer()
            }
            .padding(8)
        }
    }
}

#Preview {
    BumbleHomeView()
}

//some View
extension BumbleHomeView {
    private var header: some View {
        HStack(spacing: 0.0) {
            //1
            HStack(spacing: 0.0) {
                Image(systemName: "line.horizontal.3")
                    .padding(8)
                    .background(.black.opacity(0))
                    .onTapGesture {    }
                Image(systemName: "arrow.uturn.left")
                    .padding(8)
                    .background(.black.opacity(0))
                    .onTapGesture {    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            //2
            Text("bumble")
                .font(.title)
                .foregroundStyle(.bumbleYellow)
                .frame(maxWidth: .infinity, alignment: .center)
            //3
            Image(systemName: "slider.horizontal.3")
                .padding(8)
                .background(.black.opacity(0))
                .onTapGesture {    }
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .font(.title2)
        .fontWeight(.medium)
        .foregroundStyle(.bumbleBlack)
    }
}
