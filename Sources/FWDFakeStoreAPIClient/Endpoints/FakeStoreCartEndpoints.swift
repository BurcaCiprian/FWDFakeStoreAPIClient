//
//  FakeStoreCartEndpoints.swift
//  
//
//  Created by Burca Victor Ciprian on 03.03.2023.
//

import Foundation
import FWDNetworkingLibrary

/// Enum representing the various endpoints for the fake store cart service
enum FakeStoreCartEndpoints {
   
    /// Endpoint to get all the carts from the fake store service for a specific user.
    /// - Parameters:
    ///   - userId: The user id to get carts for
    ///   - limit: Optional limit on the number of carts to retrieve.
    ///   - sort: Optional field to sort the carts by.
    case getUserCarts(userId: Int, limit: Int?, sort: String?)

    /// Endpoint to get a single cart from the fake store service.
    /// - Parameters:
    ///   - cartId: The id of the cart to retrieve.
    case getSingleCart(cartId: Int)

    /// Endpoint to add a new cart to the fake store service.
    /// - Parameters:
    ///   - cart: The cart object to add.
    case addNewCart(cart: Cart)

    /// Endpoint to update an existing cart in the fake store service.
    /// - Parameters:
    ///   - cartId: The id of the cart to update.
    ///   - cart: The updated cart object.
    case updateCart(cartId: Int, cart: Cart)

    /// Endpoint to delete an existing cart from the fake store service.
    /// - Parameters:
    ///   - cartId: The id of the cart to delete.
    case deleteCart(cartId: Int)
}

extension FakeStoreCartEndpoints: FakeStoreEndpointType {
    
    var path: String {
        switch self {
        case .getUserCarts(let userId, _, _):
            return "/carts/user/\(userId)"
        case .getSingleCart(let cartId):
            return "/carts/\(cartId)"
        case .addNewCart:
            return "/carts"
        case .updateCart(let cartId, _):
            return "/carts/\(cartId)"
        case .deleteCart(let cartId):
            return "/carts/\(cartId)"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .getUserCarts, .getSingleCart:
            return .get
        case .addNewCart:
            return .post
        case .updateCart:
            return .put
        case .deleteCart:
            return .delete
        }
    }
    
    var queryItems: [String : String]? {
        switch self {
        case .getUserCarts(_, let limit?, let sort?):
            return [QueryItemKey.limit.rawValue: "\(limit)", QueryItemKey.sort.rawValue: sort]
        case .getSingleCart:
            return nil
        case .getUserCarts(_, limit: .none, sort: let sort?):
            return [QueryItemKey.sort.rawValue: sort]
        case .getUserCarts(_, limit: let limit?, sort: .none):
            return [QueryItemKey.limit.rawValue: "\(limit)"]
        case .getUserCarts(_, limit: .none, sort: .none):
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
        case .addNewCart(let cart), .updateCart(_, let cart):
            return try? cart.toDictionary()
        default:
            return nil
        }
    }
}

