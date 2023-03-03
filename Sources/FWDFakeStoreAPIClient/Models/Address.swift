//
//  Address.swift
//  
//
//  Created by Burca Victor Ciprian on 03.03.2023.
//

/// Struct representing an address returned by the fakestore.com API
struct Address: Codable {
    /// The street address
    let street: String
    /// The city
    let city: String
    /// The state
    let state: String
    /// The ZIP code
    let zip: String
    /// The geographical coordinates of the address
    let geo: GeoLocation
}
