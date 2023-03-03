//
//  FakeStoreEndpoints.swift
//  
//
//  Created by Burca Victor Ciprian on 01.03.2023.
//

import Foundation
import FWDNetworkingLibrary

enum FakeStoreProductEndpoints {
    case getAllProducts(limit: Int?, sort: String?)
    case getSingleProduct(productId: Int)
    case addNewProduct(product: Product)
    case updateProduct(productId: Int, product: Product)
    case deleteProduct(productId: Int)
}

extension FakeStoreProductEndpoints: FakeStoreEndpointType {
    
    var path: String {
        switch self {
        case .getAllProducts(_, _):
            return "/products"
        case .getSingleProduct(let productId):
            return "/products/\(productId)"
        case .addNewProduct:
            return "/products"
        case .updateProduct(let productId, _):
            return "/products/\(productId)"
        case .deleteProduct(let productId):
            return "/products/\(productId)"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .getAllProducts, .getSingleProduct:
            return .get
        case .addNewProduct:
            return .post
        case .updateProduct:
            return .put
        case .deleteProduct:
            return .delete
        }
    }
    
    var queryItems: [String : String]? {
        switch self {
        case .getAllProducts(let limit?, let sort?):
            return [QueryItemKey.limit.rawValue: "\(limit)", QueryItemKey.sort.rawValue: sort]
        case .getSingleProduct:
            return nil
        case .getAllProducts(limit: .none, sort: let sort?):
            return [QueryItemKey.sort.rawValue: sort]
        case .getAllProducts(limit: let limit?, sort: .none):
            return [QueryItemKey.limit.rawValue: "\(limit)"]
        case .getAllProducts(limit: .none, sort: .none):
            return nil
        default:
            return nil
        }
    }
    
    var headers: [String : String]? {
        let headers = [
            "Content-Type": "application/json",
        ]
        return headers
    }
    
    var body: [String : Any]? {
        switch self {
        case .addNewProduct(let product), .updateProduct(_, let product):
            return try? product.toDictionary()
        default:
            return nil
        }
    }
}
