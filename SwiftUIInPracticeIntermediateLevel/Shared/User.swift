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
