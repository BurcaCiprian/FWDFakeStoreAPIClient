//
//  Product.swift
//  
//
//  Created by Burca Victor Ciprian on 03.03.2023.
//

/// Struct representing a product returned by the fakestore.com API
public struct Product: Codable {
    /// The ID of the product
    let id: Int
    /// The title of the product
    let title: String?
    /// The price of the product
    let price: Double?
    /// The description of the product
    let description: String?
    /// The category of the product
    let category: String?
    /// The image URL of the product
    let image: String?
    /// The rating of the product.
    let rating: Rating?
}
