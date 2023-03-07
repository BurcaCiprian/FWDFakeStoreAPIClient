//
//  ProductServiceTests.swift
//  
//
//  Created by Burca Victor Ciprian on 07.03.2023.
//

import XCTest
@testable import FWDNetworkingLibrary
@testable import FWDFakeStoreAPIClient

class ProductServiceTests: XCTestCase {
    
    var productService: ProductService!
    
    override func setUp() {
        super.setUp()
        productService = ProductService()
    }
    
    override func tearDown() {
        productService = nil
        super.tearDown()
    }
    
    let PRODUCT_TITLE = "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops"
    let PRODUCT_PRICE = 109.95
    
    func testGetAllProducts() async throws {
        let products = try await productService.getAllProducts(limit: 10, sort: "name")
        XCTAssert(products.count == 10)
        XCTAssert(products[0].title == PRODUCT_TITLE)
        XCTAssert(products[0].price == PRODUCT_PRICE)
    }
    
    func testGetProduct() async throws {
        let product = try await productService.getProduct(id: 1)
        XCTAssert(product.title == PRODUCT_TITLE)
        XCTAssert(product.price == PRODUCT_PRICE)
    }
    
    func testAddProduct() async throws {
        let product = makeProduct()
        let addedProduct = try await productService.addProduct(product: product)
        XCTAssert(addedProduct.id == 21)
        XCTAssert(addedProduct.title == "Test Product")
        XCTAssert(addedProduct.price == 9.99)
        XCTAssert(addedProduct.category == "Test")
    }
    
    func testUpdateProduct() async throws {
        let product = makeProduct()
        let updatedProduct = try await productService.updateProduct(id: 1, product: product)
        XCTAssert(updatedProduct.id == 1)
        XCTAssert(updatedProduct.title == "Test Product")
        XCTAssert(updatedProduct.price == 9.99)
        XCTAssert(updatedProduct.category == "Test")
    }
    
    func testDeleteProduct() async throws {
        let deletedProduct = try await productService.deleteProduct(id: 1)
        XCTAssert(deletedProduct.id == 1)
        XCTAssert(deletedProduct.title == PRODUCT_TITLE)
        XCTAssert(deletedProduct.price == PRODUCT_PRICE)
    }
    
    func testGetAllCategories() async throws {
        let categories = try await productService.getAllCategories()
        XCTAssert(categories.count == 4)
        XCTAssert(categories[0] == "electronics")
        XCTAssert(categories[1] == "jewelery")
        XCTAssert(categories[2] == "men\'s clothing")
        XCTAssert(categories[3] == "women\'s clothing")
    }
    
    func testGetProductsInCategory() async throws {
        let products: [Product] = try await productService.getProductsInCategory(category: "electronics", limit: 5, sort: "name")
        XCTAssert(products.count == 6)
        XCTAssert(products[0].title == "WD 2TB Elements Portable External Hard Drive - USB 3.0 ")
        XCTAssert(products[0].category == "electronics")
    }
    
    private func makeProduct() -> Product {
        return Product(id: 1, title: "Test Product", price: 9.99, description: "This is a test product.", category: "Test", image: "https://example.com/test-product.jpg", rating: Rating(count: 3, rate: 2.0))
    }
    
}
