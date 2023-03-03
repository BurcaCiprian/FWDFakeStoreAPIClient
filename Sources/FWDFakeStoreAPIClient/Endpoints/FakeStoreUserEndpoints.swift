//
//  FakeStoreUserEndpoints.swift
//  
//
//  Created by Burca Victor Ciprian on 03.03.2023.
//
import FWDNetworkingLibrary

/// Enum defining endpoints for interacting with User objects in the FakeStore API.
enum FakeStoreUserEndpoints {
    
    /// Endpoint for getting all users from the API.
    /// - Parameters:
    ///   - limit: The maximum number of users to return (optional).
    ///   - sort: The field to sort the users by (optional).
    case getAllUsers(limit: Int?, sort: String?)
    
    /// Endpoint for getting a single user from the API.
    /// - Parameter userId: The unique identifier of the user to retrieve.
    case getSingleUser(userId: Int)
    
    /// Endpoint for adding a new user to the API.
    /// - Parameter user: The User object representing the user to add.
    case addNewUser(user: User)
    
    /// Endpoint for updating an existing user in the API.
    /// - Parameters:
    ///   - userId: The unique identifier of the user to update.
    ///   - user: The updated User object representing the changes to apply.
    case updateUser(userId: Int, user: User)
    
    /// Endpoint for deleting a user from the API.
    /// - Parameter userId: The unique identifier of the user to delete.
    case deleteUser(userId: Int)
    
}

extension FakeStoreUserEndpoints: FakeStoreEndpointType {
    
    /// The endpoint path for the user endpoint.
    var path: String {
        switch self {
        case .getAllUsers:
            return "/users"
        case .getSingleUser(let userId):
            return "/users/\(userId)"
        case .addNewUser:
            return "/users"
        case .updateUser(let userId, _):
            return "/users/\(userId)"
        case .deleteUser(let userId):
            return "/users/\(userId)"
        }
    }
    
    /// The HTTP method to use for the user endpoint.
    var method: RequestMethod {
        switch self {
        case .getAllUsers, .getSingleUser:
            return .get
        case .addNewUser:
            return .post
        case .updateUser:
            return .put
        case .deleteUser:
            return .delete
        }
    }
    
    /// Query items to add to the request URL for the user endpoint.
    var queryItems: [String : String]? {
        switch self {
        case .getAllUsers(let limit?, let sort?):
            return [QueryItemKey.limit.rawValue: "\(limit)", QueryItemKey.sort.rawValue: sort]
        case .getSingleUser:
            return nil
        case .getAllUsers(limit: .none, sort: let sort?):
            return [QueryItemKey.sort.rawValue: sort]
        case .getAllUsers(limit: let limit?, sort: .none):
            return [QueryItemKey.limit.rawValue: "\(limit)"]
        case .getAllUsers(limit: .none, sort: .none):
            return nil
        default:
            return nil
        }
    }
    
    /// Headers to add to the request for the user endpoint.
    var headers: [String : String]? {
        let headers = [
            "Content-Type": "application/json",
        ]
        return headers
    }
    
    /// The request body to send for the user endpoint.
    var body: [String : Any]? {
        switch self {
        case .addNewUser(let user), .updateUser(_, let user):
            return try? user.toDictionary()
        default:
            return nil
        }
    }
}
