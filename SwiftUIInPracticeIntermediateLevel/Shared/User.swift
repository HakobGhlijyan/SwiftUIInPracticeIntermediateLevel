//
//  User.swift
//  SwiftUIInPracticeIntermediateLevel
//
//  Created by Hakob Ghlijyan on 29.03.2024.
//

import Foundation

struct UserArray: Codable {
    let users: [User]
    let total, skip, limit: Int
}

struct User: Codable, Identifiable {
    let id: Int
    let firstName, lastName: String
    let age: Int
    let email, phone, username, password: String
    let image: String
    let height: Int
    let weight: Double
    
    var work: String { "Worker as Some Job" }
    var education: String { "Graduste Degree" }
    var aboutMe: String { "This is a sentence abount me that look good on my profile!" }
    
    var basics:[UserInterest] {
        [
        UserInterest(iconName: "ruler", emoji: nil, text: "\(height)"),
        UserInterest(iconName: "guarduationcap", emoji: nil, text: "\(education)"),
        UserInterest(iconName: "wineglass", emoji: nil, text: "Socially"),
        UserInterest(iconName: "moon.stars.fill", emoji: nil, text: "Virgo"),
        ]
    }
    var interests:[UserInterest] {
        [
        UserInterest(iconName: nil, emoji: "🏃🏼‍➡️", text: "Running"),
        UserInterest(iconName: nil, emoji: "👟", text: "Gym"),
        UserInterest(iconName: nil, emoji: "🎤", text: "Music"),
        UserInterest(iconName: nil, emoji: "🍚", text: "Cooking"),
        ]
    }
    
    var images: [String] {
        ["https://picsum.photos/500/500","https://picsum.photos/800/800","https://picsum.photos/700/700",]
    }
    
    static var mock: User {
        User(
            id: 007,
            firstName: "Hakob",
            lastName: "Ghlijyan",
            age: 30,
            email: "hakobghlijyan@gmail.com",
            phone: "+1 818 000 000",
            username: "",
            password: "",
            image: Constants.randomImage,
            height: 180,
            weight: 200
        )
    }
}
