//
//  FakeStoreCartEndpoints.swift
//  
//
//  Created by Burca Victor Ciprian on 03.03.2023.
//

import Foundation
import FWDNetworkingLibrary

enum FakeStoreCartEndpoints {
    case getAllCarts(limit: Int?, sort: String?)
    case getSingleCart(cartId: Int)
    case addNewCart(cart: Cart)
    case updateCart(cartId: Int, cart: Cart)
    case deleteCart(cartId: Int)
}

extension FakeStoreCartEndpoints: FakeStoreEndpointType {
    
    var path: String {
        switch self {
        case .getAllCarts(_, _):
            return "/carts"
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
        case .getAllCarts, .getSingleCart:
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
        case .getAllCarts(let limit?, let sort?):
            return [QueryItemKey.limit.rawValue: "\(limit)", QueryItemKey.sort.rawValue: sort]
        case .getSingleCart:
            return nil
        case .getAllCarts(limit: .none, sort: let sort?):
            return [QueryItemKey.sort.rawValue: sort]
        case .getAllCarts(limit: let limit?, sort: .none):
            return [QueryItemKey.limit.rawValue: "\(limit)"]
        case .getAllCarts(limit: .none, sort: .none):
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

