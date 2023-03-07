//
//  CartService.swift
//  
//
//  Created by Burca Victor Ciprian on 03.03.2023.
//
import Foundation
import FWDNetworkingLibrary

/// Protocol for interacting with a shopping cart service.
public protocol CartServiceType {
    
    /// Retrieves the cart for the specified user.
    /// - Parameters:
    ///   - id: The cart identifier.
    /// - Returns: The user's cart.
    func getCart(id: Int) async throws -> Cart
    
    /// Adds a product to the cart for the specified user.
    /// - Parameters:
    ///   - userId: The user identifier.
    ///   - productId: The product identifier.
    ///   - quantity: The quantity of the product to add.
    /// - Returns: The updated cart.
    func addProductToCart(userId: Int, productId: Int, quantity: Int) async throws -> Cart
    
    /// Updates the quantity of a product in the cart for the specified user.
    /// - Parameters:
    ///   - userId: The user identifier.
    ///   - productId: The product identifier.
    ///   - quantity: The new quantity of the product.
    /// - Returns: The updated cart.
    func updateProductQuantity(userId: Int, productId: Int, quantity: Int) async throws -> Cart
    
    /// Removes a product from the cart for the specified user.
    /// - Parameters:
    ///   - userId: The user identifier.
    ///   - productId: The product identifier.
    /// - Returns: The updated cart.
    func removeProductFromCart(userId: Int, productId: Int) async throws -> Cart
    
    /// Clears the cart for the specified user.
    /// - Parameter userId: The user identifier.
    /// - Returns: An empty cart.
    func clearCart(userId: Int) async throws -> Cart
}

// Implementation of the Cart service
public class CartService: CartServiceType, NetworkServiceType {
    
    public var apiRequestBuilder: APIRequestBuilderType = APIRequestBuilder()
    
    public var sessionTaskDelegate: SessionTaskDelegateType? = nil
    
    public var requestModifiers: [RequestModifierType] = []
    
    public var responseModifiers: [ResponseModifierType] = []
    
    public func getCart(id: Int) async throws -> Cart {
        try await sendRequest(for: FakeStoreCartEndpoints.getSingleCart(cartId: id))
    }
    
    // dummmy implementation since the fake store api does not update a real database
    public func addProductToCart(userId: Int, productId: Int, quantity: Int) async throws -> Cart {
        await withCheckedContinuation({ continuation in
            continuation.resume(returning: Cart(id: 1, date: nil, userId: 1, products: []))
        })
    }
    
    // dummmy implementation since the fake store api does not update a real database
    public func updateProductQuantity(userId: Int, productId: Int, quantity: Int) async throws -> Cart {
        await withCheckedContinuation({ continuation in
            continuation.resume(returning: Cart(id: 1, date: nil, userId: 1, products: []))
        })
    }
    
    // dummmy implementation since the fake store api does not update a real database
    public func removeProductFromCart(userId: Int, productId: Int) async throws -> Cart {
        await withCheckedContinuation({ continuation in
            continuation.resume(returning: Cart(id: 1, date: nil, userId: 1, products: []))
        })
    }
    
    // dummmy implementation since the fake store api does not update a real database
    public func clearCart(userId: Int) async throws -> Cart {
        await withCheckedContinuation({ continuation in
            continuation.resume(returning: Cart(id: 1, date: nil, userId: 1, products: []))
        })
    }
    
}
