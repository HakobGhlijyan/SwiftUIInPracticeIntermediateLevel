//
//  SwiftUIInPracticeIntermediateLevelApp.swift
//  SwiftUIInPracticeIntermediateLevel
//
//  Created by Hakob Ghlijyan on 29.03.2024.
//

import SwiftUI
import SwiftfulRouting

@main
struct SwiftUIInPracticeIntermediateLevelApp: App {
    var body: some Scene {
        WindowGroup {
            RouterView { _ in
                ContentView()
            }
        }
    }
}

//Jest Smaxivaniya nazad
extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
