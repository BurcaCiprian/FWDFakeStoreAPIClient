//
//  User.swift
//  
//
//  Created by Burca Victor Ciprian on 03.03.2023.
//

/// Struct representing a user returned by the fakestore.com API
public struct User: Codable {
    /// The ID of the user
    public let id: Int
    /// The username of the user
    public let username: String?
    /// The email address of the user
    public let email: String?
    /// The user's address
    public let address: Address?
    /// The user's phone number
    public let phone: String?
    /// The user's website
    public let website: String?
    /// The user's company
    public let company: Company?
    
    /// The user's name
    public let name: Name?
    
    public struct Name: Codable {
        /// The user's first name
        public let firstname: String?
        /// The user's last name
        public let lastname: String?
    }
}
