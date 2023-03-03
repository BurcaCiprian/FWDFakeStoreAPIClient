//
//  GeoLocation.swift
//  
//
//  Created by Burca Victor Ciprian on 03.03.2023.
//

/// Struct representing geographical coordinates returned by the fakestore.com API
struct GeoLocation: Codable {
    /// The latitude of the location
    let lat: String
    /// The longitude of the location
    let lng: String
}
