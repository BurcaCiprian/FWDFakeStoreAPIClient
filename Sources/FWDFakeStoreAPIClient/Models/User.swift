//
//  User.swift
//  
//
//  Created by Burca Victor Ciprian on 03.03.2023.
//

/// Struct representing a user returned by the fakestore.com API
struct User: Codable {
    /// The ID of the user
    let id: Int
    /// The username of the user
    let username: String
    /// The email address of the user
    let email: String
    /// The user's address
    let address: Address
    /// The user's phone number
    let phone: String
    /// The user's website
    let website: String
    /// The user's company
    let company: Company
}
