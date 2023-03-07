//
//  ProductService.swift
//  
//
//  Created by Burca Victor Ciprian on 03.03.2023.
//
import Foundation
import FWDNetworkingLibrary

/**
 A service for managing products in the store.
 */
public protocol ProductServiceType {
    /**
     Retrieves all the products in the store.

     - Parameter limit: The maximum number of products to return.
     - Parameter sort: The sort order for the products.
     - Returns: An array of `Product` objects.
     - Throws: A `APIError` if there is an issue with the network request.
     */
    func getAllProducts(limit: Int?, sort: String?) async throws -> [Product]
    
    /**
     Retrieves a single product from the store.
     
     - Parameter id: The ID of the product to retrieve.
     - Returns: A `Product` object.
     - Throws: A `APIError` if there is an issue with the network request.
     */
    func getProduct(id: Int) async throws -> Product
    
    /**
     Adds a new product to the store.
     
     - Parameter product: The `Product` object to add.
     - Returns: The `Product` object with the newly assigned ID.
     - Throws: A `APIError` if there is an issue with the network request.
     */
    func addProduct(product: Product) async throws -> Product
    
    /**
     Updates an existing product in the store.
     
     - Parameter id: The ID of the product to update.
     - Parameter product: The `Product` object with updated values.
     - Returns: The updated `Product` object.
     - Throws: A `APIError` if there is an issue with the network request.
     */
    func updateProduct(id: Int, product: Product) async throws -> Product
    
    /**
     Deletes a product from the store.
     
     - Parameter id: The ID of the product to delete.
     - Returns: The deleted `Product` object.
     - Throws: A `APIError` if there is an issue with the network request.
     */
    func deleteProduct(id: Int) async throws -> Product
}


public class ProductService: ProductServiceType, NetworkServiceType {
    
    public var apiRequestBuilder: APIRequestBuilderType = APIRequestBuilder()
    
    public var sessionTaskDelegate: SessionTaskDelegateType? = nil
    
    public var requestModifiers: [RequestModifierType] = []
    
    public var responseModifiers: [ResponseModifierType] = []
    
    public func getAllProducts(limit: Int?, sort: String?) async throws -> [Product] {
        try await sendRequest(for: FakeStoreProductEndpoints.getAllProducts(limit: limit, sort: sort))
    }
    
    public func getProduct(id: Int) async throws -> Product {
        try await sendRequest(for: FakeStoreProductEndpoints.getSingleProduct(productId: id))
    }
    
    public func addProduct(product: Product) async throws -> Product {
        try await sendRequest(for: FakeStoreProductEndpoints.addNewProduct(product: product))
    }
    
    public func updateProduct(id: Int, product: Product) async throws -> Product {
        try await sendRequest(for: FakeStoreProductEndpoints.updateProduct(productId: id, product: product))
    }
    
    public func deleteProduct(id: Int) async throws -> Product {
        try await sendRequest(for: FakeStoreProductEndpoints.deleteProduct(productId: id))
    }
    
}
