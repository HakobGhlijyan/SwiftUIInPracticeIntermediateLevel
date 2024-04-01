//
//  ContentView.swift
//  SwiftUIInPracticeIntermediateLevel
//
//  Created by Hakob Ghlijyan on 29.03.2024.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting
import SwiftfulRecursiveUI

struct ContentView: View {
    
    @Environment(\.router) var router
    
    var body: some View {
        List {
            Button("Open Spotify") {
                //No MVVM
                router.showScreen(.fullScreenCover) { _ in
                    SpotifyHomeView()
                }
                // IN MVVM
//                router.showScreen(.fullScreenCover) { router in
//                    SpotifyHomeView(viewModel: SpotifyHomeViewModel(router: router))
//                }
            }
        }
    }
    
}

#Preview {
    RouterView { _ in
        ContentView()
    }
}
