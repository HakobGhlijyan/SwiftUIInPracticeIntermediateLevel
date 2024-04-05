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
                router.showScreen(.fullScreenCover) { _ in
                    SpotifyHomeView()
                }
            }
            Button("Open Bumble") {
                router.showScreen(.fullScreenCover) { _ in
                    BumbleHomeView()
                }
            }
        }
        //Icon
        HStack {
            //Spotify
            Button(action: {
                router.showScreen(.fullScreenCover) { _ in
                    SpotifyHomeView()
                }
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                        .fill(.black)
                        .frame(width: 100, height: 100)
                    Text("Spotify")
                        .font(.title2)
                        .foregroundStyle(.green)
                        .bold()
                }
            })
            //Bumble
            Button(action: {
                router.showScreen(.fullScreenCover) { _ in
                    BumbleHomeView()
                }
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                        .fill(.bumbleGray)
                        .frame(width: 100, height: 100)
                    Text("Bumble")
                        .font(.title2)
                        .foregroundStyle(.bumbleYellow)
                        .bold()
                }
            })
            
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(40)
        
        
    }
}

#Preview {
    RouterView { _ in
        ContentView()
    }
}
