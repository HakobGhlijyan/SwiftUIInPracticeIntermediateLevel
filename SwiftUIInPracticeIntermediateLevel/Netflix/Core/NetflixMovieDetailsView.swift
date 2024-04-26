//
//  NetflixMovieDetailsView.swift
//  SwiftUIInPracticeIntermediateLevel
//
//  Created by Hakob Ghlijyan on 26.04.2024.
//

import SwiftUI

struct NetflixMovieDetailsView: View {
    var product: Product = .mock
    @State private var progress: Double = 0.3
    
    var body: some View {
        ZStack {
            Color.netflixBlack.ignoresSafeArea()
            Color.netflixDarkGray.opacity(0.3).ignoresSafeArea()
            
            VStack(spacing: 0) {
                NetflixMovieHeaderView(
                    imageName: product.firstImage,
                    progress: progress,
                    onAirPlayPressed: {
                        
                    },
                    onXMarkPressed: {
                        
                    }
                )
                
                ScrollView(.vertical) {
                    VStack(spacing: 16.0) {
                        NetflixDetailsProductView(
                            title: product.title,
                            isNew: true,
                            yearReleased: "2024",
                            seasonCount: 4,
                            hasClosedCaptions: true,
                            isTopTen: 6,
                            descriptionText: product.description,
                            castText: "Cast: Hakob, Your Name, Someone Else",
                            onPlayPressed: {
                                
                            },
                            onDownloadPressed: {
                                
                            }
                        )
                    }
                    .padding(8)
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}

#Preview {
    NetflixMovieDetailsView()
}
