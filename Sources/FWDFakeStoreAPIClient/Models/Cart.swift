//
//  Cart.swift
//  
//
//  Created by Burca Victor Ciprian on 03.03.2023.
//


// A representation of a Cart object from the FakeStore API.
struct Cart: Codable {
    
    // The ID of the cart.
    let id: String
    
    // The date and time the cart was created.
    let date: String
    
    // The ID of the user associated with the cart, if any.
    let userId: Int?
    
    // An array of CartItem objects representing the items in the cart.
    let products: [Product]
    
}
