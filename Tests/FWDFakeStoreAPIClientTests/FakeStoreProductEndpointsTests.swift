//
//  FakeStoreProductEndpointsTests.swift
//  
//
//  Created by Burca Victor Ciprian on 03.03.2023.
//

import XCTest
@testable import FWDFakeStoreAPIClient

final class FakeStoreProductEndpointsTests: XCTestCase {
    // MARK: - Test Cases
    
    func testGetAllProductsWithLimitAndSortQueryItems() throws {
        // given
        let limit = 10
        let sort = "name"
        let endpoint = FakeStoreProductEndpoints.getAllProducts(limit: limit, sort: sort)
        
        // when
        let path = try XCTUnwrap(endpoint.path)
        let method = endpoint.method
        let headers = endpoint.headers
        let queryItems = endpoint.queryItems
        
        // then
        XCTAssertEqual(path, "/products")
        XCTAssertEqual(method, .get)
        XCTAssertEqual(headers,  TestConstants.DEFAULT_HEADERS)
        XCTAssertEqual(queryItems, ["limit": "\(limit)", "sort": sort])
    }
    
    func testGetSingleProductWithProductId() throws {
        // given
        let productId = 123
        let endpoint = FakeStoreProductEndpoints.getSingleProduct(productId: productId)
        
        // when
        let path = try XCTUnwrap(endpoint.path)
        let method = endpoint.method
        let headers = endpoint.headers
        let queryItems = endpoint.queryItems
        
        // then
        XCTAssertEqual(path, "/products/\(productId)")
        XCTAssertEqual(method, .get)
        XCTAssertEqual(headers,  TestConstants.DEFAULT_HEADERS)
        XCTAssertEqual(queryItems, nil)
    }
    
    func testGetAllProductsWithSortQueryItem() throws {
        // given
        let sort = "price"
        let endpoint = FakeStoreProductEndpoints.getAllProducts(limit: nil, sort: sort)
        
        // when
        let path = try XCTUnwrap(endpoint.path)
        let method = endpoint.method
        let headers = endpoint.headers
        let queryItems = endpoint.queryItems
        
        // then
        XCTAssertEqual(path, "/products")
        XCTAssertEqual(method, .get)
        XCTAssertEqual(headers, TestConstants.DEFAULT_HEADERS)
        XCTAssertEqual(queryItems, ["sort": sort])
    }
    
    func testGetAllProductsWithLimitQueryItem() throws {
        // given
        let limit = 20
        let endpoint = FakeStoreProductEndpoints.getAllProducts(limit: limit, sort: nil)
        
        // when
        let path = try XCTUnwrap(endpoint.path)
        let method = endpoint.method
        let headers = endpoint.headers
        let queryItems = endpoint.queryItems
        
        // then
        XCTAssertEqual(path, "/products")
        XCTAssertEqual(method, .get)
        XCTAssertEqual(headers, TestConstants.DEFAULT_HEADERS)
        XCTAssertEqual(queryItems, ["limit": "\(limit)"])
    }
    
    func testGetAllProductsWithNoQueryItems() throws {
        // given
        let endpoint = FakeStoreProductEndpoints.getAllProducts(limit: nil, sort: nil)
        
        // when
        let path = try XCTUnwrap(endpoint.path)
        let method = endpoint.method
        let headers = endpoint.headers
        
        // then
        XCTAssertEqual(path, "/products")
        XCTAssertEqual(method, .get)
        XCTAssertEqual(endpoint.queryItems, nil)
        XCTAssertEqual(headers, TestConstants.DEFAULT_HEADERS)
    }
    
    func testGetAllProductsWithoutQueryItems() throws {
        // given
        let endpoint = FakeStoreProductEndpoints.getAllProducts(limit: nil, sort: nil)
        
        // when
        let path = try XCTUnwrap(endpoint.path)
        let method = endpoint.method
        let headers = endpoint.headers
        let queryItems = endpoint.queryItems
        
        // then
        unusedPropertiesTest(sut: endpoint)
        XCTAssertEqual(path, "/products")
        XCTAssertEqual(method, .get)
        XCTAssertEqual(headers, TestConstants.DEFAULT_HEADERS)
        XCTAssertEqual(queryItems, nil)
    }
    
    func testAddNewProduct() throws {
        let product = generateMockProduct()
        
        let endpoint = FakeStoreProductEndpoints.addNewProduct(product: product)
        
        XCTAssertEqual(endpoint.method, .post)
        XCTAssertEqual(endpoint.path, "/products")
        XCTAssertNil(endpoint.queryItems)
        XCTAssertEqual(endpoint.body?.count, 6)
        XCTAssertEqual(endpoint.body?["title"] as? String, product.title)
        XCTAssertEqual(endpoint.body?["price"] as? Double, product.price)
    }
    
    func testUpdateProduct() throws {
        let productId = 1
        let product = generateMockProduct()
        
        let endpoint = FakeStoreProductEndpoints.updateProduct(productId: productId, product: product)
        
        XCTAssertEqual(endpoint.method, .put)
        XCTAssertEqual(endpoint.path, "/products/\(productId)")
        XCTAssertNil(endpoint.queryItems)
        XCTAssertEqual(endpoint.body?.count, 6)
        XCTAssertEqual(endpoint.body?["title"] as? String, product.title)
        XCTAssertEqual(endpoint.body?["price"] as? Double, product.price)
    }
    
    func testDeleteProduct() throws {
        let productId = 1
        
        let endpoint = FakeStoreProductEndpoints.deleteProduct(productId: productId)
        
        XCTAssertEqual(endpoint.method, .delete)
        XCTAssertEqual(endpoint.path, "/products/\(productId)")
        XCTAssertNil(endpoint.queryItems)
        XCTAssertNil(endpoint.body)
    }
    
    
}

private extension FakeStoreProductEndpointsTests {
    private func unusedPropertiesTest(sut: FakeStoreProductEndpoints) {
        XCTAssertEqual(sut.user, nil)
        XCTAssertEqual(sut.password, nil)
        XCTAssertEqual(sut.scheme, "https")
        XCTAssertEqual(sut.fragment, nil)
        XCTAssertEqual(sut.port, nil)
        XCTAssertEqual(sut.host, "fakestoreapi.com")
        XCTAssertEqual(sut.body, nil)
    }
    
    private func generateMockProduct() -> Product {
        return Product(id: 1, title: "Test Product", price: 9.99, description: "This is a test product.", category: "Test", image: "https://example.com/test-product.jpg")
    }
}
