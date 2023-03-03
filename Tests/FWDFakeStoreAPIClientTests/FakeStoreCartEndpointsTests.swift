//
//  FakeStoreCartEndpointsTests.swift
//  
//
//  Created by Burca Victor Ciprian on 03.03.2023.
//

import XCTest

import XCTest
@testable import FWDFakeStoreAPIClient

final class FakeStoreCartEndpointsTests: XCTestCase {
    // MARK: - Test Cases
    func testGetAllCartsEndpoint() {
        // given
        let limit = 10
        let sort = "desc"
        let endpoint = FakeStoreCartEndpoints.getAllCarts(limit: limit, sort: sort)
        
        // when
        let expectedPath = "/carts"
        let expectedMethod = endpoint.method
        let expectedQueryItems = ["limit": "\(limit)", "sort": sort]
        let expectedHeaders = TestConstants.DEFAULT_HEADERS
        let expectedBody: [String: Any]? = nil
        
        // then
        XCTAssertEqual(endpoint.path, expectedPath)
        XCTAssertEqual(endpoint.method, expectedMethod)
        XCTAssertEqual(endpoint.queryItems as NSDictionary?, expectedQueryItems as NSDictionary?)
        XCTAssertEqual(endpoint.headers as NSDictionary?, expectedHeaders as NSDictionary?)
        XCTAssertEqual(endpoint.body as NSDictionary?, expectedBody as NSDictionary?)
        unusedPropertiesTest(sut: endpoint)
    }
    
    func testGetAllCartsEndpointNoLimit() {
        // given
        let sort = "desc"
        let endpoint = FakeStoreCartEndpoints.getAllCarts(limit: nil, sort: sort)
        
        // when
        let expectedPath = "/carts"
        let expectedMethod = endpoint.method
        let expectedQueryItems = ["sort": sort]
        let expectedHeaders = TestConstants.DEFAULT_HEADERS
        let expectedBody: [String: Any]? = nil
        
        // then
        XCTAssertEqual(endpoint.path, expectedPath)
        XCTAssertEqual(endpoint.method, expectedMethod)
        XCTAssertEqual(endpoint.queryItems as NSDictionary?, expectedQueryItems as NSDictionary?)
        XCTAssertEqual(endpoint.headers as NSDictionary?, expectedHeaders as NSDictionary?)
        XCTAssertEqual(endpoint.body as NSDictionary?, expectedBody as NSDictionary?)
    }
    
    func testGetAllCartsEndpointNoSort() {
        // given
        let limit = 20
        let endpoint = FakeStoreCartEndpoints.getAllCarts(limit: limit, sort: nil)
                
        // when
        let expectedPath = "/carts"
        let expectedMethod = endpoint.method
        let expectedHeaders = TestConstants.DEFAULT_HEADERS
        let expectedBody: [String: Any]? = nil
        
        // then
        XCTAssertEqual(endpoint.path, expectedPath)
        XCTAssertEqual(endpoint.method, expectedMethod)
        XCTAssertEqual(endpoint.queryItems, ["limit": "\(limit)"])
        XCTAssertEqual(endpoint.headers as NSDictionary?, expectedHeaders as NSDictionary?)
        XCTAssertEqual(endpoint.body as NSDictionary?, expectedBody as NSDictionary?)
    }
    
    func testGetAllCartsEndpointNoQueryItems() {
        // given
        let endpoint = FakeStoreCartEndpoints.getAllCarts(limit: nil, sort: nil)
                
        // when
        let expectedPath = "/carts"
        let expectedMethod = endpoint.method
        let expectedHeaders = TestConstants.DEFAULT_HEADERS
        let expectedBody: [String: Any]? = nil
        
        // then
        XCTAssertEqual(endpoint.path, expectedPath)
        XCTAssertEqual(endpoint.method, expectedMethod)
        XCTAssertEqual(endpoint.queryItems, nil)
        XCTAssertEqual(endpoint.headers as NSDictionary?, expectedHeaders as NSDictionary?)
        XCTAssertEqual(endpoint.body as NSDictionary?, expectedBody as NSDictionary?)
    }
    
    func testGetSingleCartEndpoint() {
        // given
        let cartId = 1
        let endpoint = FakeStoreCartEndpoints.getSingleCart(cartId: cartId)
        
        // when
        let expectedPath = "/carts/\(cartId)"
        let expectedMethod = endpoint.method
        let expectedQueryItems: [String: String]? = nil
        let expectedHeaders = TestConstants.DEFAULT_HEADERS
        let expectedBody: [String: Any]? = nil
        
        // then
        XCTAssertEqual(endpoint.path, expectedPath)
        XCTAssertEqual(endpoint.method, expectedMethod)
        XCTAssertEqual(endpoint.queryItems as NSDictionary?, expectedQueryItems as NSDictionary?)
        XCTAssertEqual(endpoint.headers as NSDictionary?, expectedHeaders as NSDictionary?)
        XCTAssertEqual(endpoint.body as NSDictionary?, expectedBody as NSDictionary?)
    }
    
    func testAddNewCartEndpoint() {
        // given
        let newCart = Cart(id: "1", date: "2022-03-01", userId: 1, products: [])
        let endpoint = FakeStoreCartEndpoints.addNewCart(cart: newCart)
        
        // when
        let expectedPath = "/carts"
        let expectedMethod = endpoint.method
        let expectedQueryItems: [String: String]? = nil
        let expectedHeaders = TestConstants.DEFAULT_HEADERS
        let expectedBody = try? newCart.toDictionary()
        
        // then
        XCTAssertEqual(endpoint.path, expectedPath)
        XCTAssertEqual(endpoint.method, expectedMethod)
        XCTAssertEqual(endpoint.queryItems as NSDictionary?, expectedQueryItems as NSDictionary?)
        XCTAssertEqual(endpoint.headers as NSDictionary?, expectedHeaders as NSDictionary?)
        XCTAssertEqual(endpoint.body as NSDictionary?, expectedBody as NSDictionary?)
    }
    
    func testUpdateCartEndpoint() {
        // given
        let cartId = 1
        let updatedCart = Cart(id: "1", date: "2022-03-01", userId: 1, products: [])
        let endpoint = FakeStoreCartEndpoints.updateCart(cartId: cartId, cart: updatedCart)
        
        // when
        let expectedPath = "/carts/\(cartId)"
        let expectedMethod = endpoint.method
        let expectedQueryItems: [String: String]? = nil
        let expectedHeaders = TestConstants.DEFAULT_HEADERS
        let expectedBody = try? updatedCart.toDictionary()
        
        // then
        XCTAssertEqual(endpoint.path, expectedPath)
        XCTAssertEqual(endpoint.method, expectedMethod)
        XCTAssertEqual(endpoint.queryItems as NSDictionary?, expectedQueryItems as NSDictionary?)
        XCTAssertEqual(endpoint.headers as NSDictionary?, expectedHeaders as NSDictionary?)
        XCTAssertEqual(endpoint.body as NSDictionary?, expectedBody as NSDictionary?)
    }
    
    func testDeleteCart() throws {
        let cartId = 1
        
        let endpoint = FakeStoreCartEndpoints.deleteCart(cartId: cartId)
        
        XCTAssertEqual(endpoint.method, .delete)
        XCTAssertEqual(endpoint.path, "/carts/\(cartId)")
        XCTAssertNil(endpoint.queryItems)
        XCTAssertNil(endpoint.body)
    }
}

private extension FakeStoreCartEndpointsTests {
    private func unusedPropertiesTest(sut: FakeStoreCartEndpoints) {
        XCTAssertEqual(sut.user, nil)
        XCTAssertEqual(sut.password, nil)
        XCTAssertEqual(sut.scheme, "https")
        XCTAssertEqual(sut.fragment, nil)
        XCTAssertEqual(sut.port, nil)
        XCTAssertEqual(sut.host, "fakestore.com")
    }
}
