//
//  CartServiceTests.swift
//  
//
//  Created by Burca Victor Ciprian on 04.03.2023.
//

import XCTest
@testable import FWDFakeStoreAPIClient

class CartServiceTests: XCTestCase {

    // MARK: - Properties

    var cartService: CartService!

    // MARK: - Set Up & Tear Down

    override func setUpWithError() throws {
        try super.setUpWithError()
        cartService = CartService()
    }

    override func tearDownWithError() throws {
        cartService = nil
        try super.tearDownWithError()
    }

    // MARK: - Tests

    func testGetCart() async throws {
        // Given
        let cartId = 1

        // When
        let cart = try await cartService.getCart(id: cartId)

        // Then
        XCTAssertNotNil(cart)

    }
    
    func testAddProductToCart() async throws {

        // When
        let cart = try await cartService.addProductToCart(userId: 1, productId: 1, quantity: 1)

        // Then
        XCTAssertNotNil(cart)

    }
    
    func testRemoveProductFromCart() async throws {

        // When
        let cart = try await cartService.removeProductFromCart(userId: 1, productId: 1)

        // Then
        XCTAssertNotNil(cart)

    }
    
    func testUpdateProductQuantity() async throws {

        // When
        let cart = try await cartService.updateProductQuantity(userId: 1, productId: 1, quantity: 2)

        // Then
        XCTAssertNotNil(cart)

    }
 
    func testClearCart() async throws {

        // When
        let cart = try await cartService.clearCart(userId: 1)

        // Then
        XCTAssertNotNil(cart)

    }

}
