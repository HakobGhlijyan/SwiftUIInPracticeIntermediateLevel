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
            Button("Open Netflix") {
                router.showScreen(.fullScreenCover) { _ in
                    NetflixHomeView()
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
            //Netflix
            Button(action: {
                router.showScreen(.fullScreenCover) { _ in
                    NetflixHomeView()
                }
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                        .fill(.netflixBlack)
                        .frame(width: 100, height: 100)
                    Text("Netflix")
                        .font(.title2)
                        .foregroundStyle(.netflixRed)
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
