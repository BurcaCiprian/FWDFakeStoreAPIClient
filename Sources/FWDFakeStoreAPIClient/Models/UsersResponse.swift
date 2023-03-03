//
//  UsersResponse.swift
//  
//
//  Created by Burca Victor Ciprian on 03.03.2023.
//

/// Struct representing a list of users returned by the fakestore.com API
struct UsersResponse: Codable {
    /// An array of users
    let users: [User]
}
