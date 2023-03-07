//
//  Address.swift
//  
//
//  Created by Burca Victor Ciprian on 03.03.2023.
//

/// Struct representing an address returned by the fakestore.com API
public struct Address: Codable {
    /// The geolocation of the address.
    public let geolocation: GeoLocation
    /// The city of the address.
    public let city: String
    /// The street of the address.
    public let street: String
    /// The number of the address.
    public let number: Int
    /// The zipcode of the address.
    public let zipcode: String
}
