//
//  Product.swift
//  SwiftUIInPracticeIntermediateLevel
//
//  Created by Hakob Ghlijyan on 29.03.2024.
//

import Foundation

struct ProductArray: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

struct Product: Codable, Identifiable {
    let id: Int
    let title, description: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
    let images: [String]
    
    var firstImage: String {
        images.first ?? Constants.randomImage
    }
    
    static var mock: Product = Product(
        id: 123,
        title: "Example product title",
        description: "This is some mock product description that goes here",
        price: 999,
        discountPercentage: 15,
        rating: 4.5,
        stock: 50,
        brand: "Apple",
        category: "Electronic Device",
        thumbnail: Constants.randomImage,
        images: [
            Constants.randomImage,
            Constants.randomImage,
            Constants.randomImage
        ]
    )
    
    static var mockProducts: [Product] = [
        Product(
            id: 1,
            title: "EcoSip Straw",
            description: "An eco-friendly reusable straw made from sustainable materials.",
            price: 899, // in cents
            discountPercentage: 10.0, // 10% discount
            rating: 4.5,
            stock: 100,
            brand: "EcoSip",
            category: "Kitchen & Dining",
            thumbnail: "https://example.com/thumbnails/ecosip_straw.jpg",
            images: [
                Constants.randomImage,
                Constants.randomImage,
                Constants.randomImage
            ]
        ),
        // Add more product instances as needed...
        Product(
            id: 2,
            title: "Organic Cotton Tote Bag",
            description: "A stylish tote bag made from 100% organic cotton, perfect for carrying groceries or everyday essentials.",
            price: 1499, // in cents
            discountPercentage: 15.0, // 15% discount
            rating: 4.8,
            stock: 50,
            brand: "GreenTote",
            category: "Fashion & Accessories",
            thumbnail: "https://example.com/thumbnails/organic_tote_bag.jpg",
            images: [
                Constants.randomImage,
                Constants.randomImage,
                Constants.randomImage
            ]
        ),
        // Adding more product instances...
        Product(
            id: 3,
            title: "Bamboo Travel Cutlery Set",
            description: "A compact and sustainable cutlery set made from bamboo, perfect for eco-conscious travelers.",
            price: 1299, // in cents
            discountPercentage: 20.0, // 20% discount
            rating: 4.7,
            stock: 30,
            brand: "BambooEssentials",
            category: "Travel & Outdoors",
            thumbnail: "https://example.com/thumbnails/bamboo_cutlery_set.jpg",
            images: [
                Constants.randomImage,
                Constants.randomImage,
                Constants.randomImage
            ]
        ),
        // Continue adding product instances...
        Product(
            id: 4,
            title: "Recycled PET Yoga Mat",
            description: "A high-quality yoga mat made from recycled PET bottles, providing both comfort and sustainability.",
            price: 1999, // in cents
            discountPercentage: 0.0, // No discount
            rating: 4.6,
            stock: 20,
            brand: "EcoYoga",
            category: "Fitness & Wellness",
            thumbnail: "https://example.com/thumbnails/recycled_pet_yoga_mat.jpg",
            images: [
                Constants.randomImage,
                Constants.randomImage,
                Constants.randomImage
            ]
        )
        // Add more products until reaching 10...
    ]
    
}

struct ProductRow: Identifiable {
    let id = UUID().uuidString
    let title: String
    let products:[Product]
}


