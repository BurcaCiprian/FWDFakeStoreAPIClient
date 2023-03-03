//
//  Company.swift
//  
//
//  Created by Burca Victor Ciprian on 03.03.2023.
//

/// Struct representing a company returned by the fakestore.com API
struct Company: Codable {
    /// The name of the company
    let name: String
    /// The catchphrase of the company
    let catchPhrase: String
    /// The company's business activity
    let bs: String
}
