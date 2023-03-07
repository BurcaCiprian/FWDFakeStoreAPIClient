//
//  UserService.swift
//  
//
//  Created by Burca Victor Ciprian on 03.03.2023.
//

import Foundation
import FWDNetworkingLibrary

/// A protocol defining the methods for interacting with the user service.
public protocol UserServiceType {
    
    /// Retrieves all users.
    /// - Parameters:
    ///   - limit: The maximum number of users to retrieve.
    ///   - sort: The field to sort the users by.
    /// - Returns: An array of `User` objects.
    func getAllUsers(limit: Int?, sort: String?) async throws -> [User]
    
    /// Retrieves a single user.
    /// - Parameter id: The ID of the user to retrieve.
    /// - Returns: A `User` object.
    func getUser(id: Int) async throws -> User
    
    /// Adds a new user.
    /// - Parameter user: The user object to add.
    /// - Returns: The added `User` object.
    func addUser(user: User) async throws -> User
    
    /// Updates an existing user.
    /// - Parameters:
    ///   - id: The ID of the user to update.
    ///   - user: The updated user object.
    /// - Returns: The updated `User` object.
    func updateUser(id: Int, user: User) async throws -> User
    
    /// Deletes a user.
    /// - Parameter id: The ID of the user to delete.
    /// - Returns: The deleted `User` object.
    func deleteUser(id: Int) async throws -> User
}


public class UserService: UserServiceType, NetworkServiceType {
    
    public var apiRequestBuilder: APIRequestBuilderType = APIRequestBuilder()
    
    public var sessionTaskDelegate: SessionTaskDelegateType? = nil
    
    public var requestModifiers: [RequestModifierType] = []
    
    public var responseModifiers: [ResponseModifierType] = []
    
    public func getAllUsers(limit: Int?, sort: String?) async throws -> [User] {
        try await sendRequest(for: FakeStoreUserEndpoints.getAllUsers(limit: limit, sort: sort))
    }
    
    public func getUser(id: Int) async throws -> User {
        try await sendRequest(for: FakeStoreUserEndpoints.getSingleUser(userId: id))
    }
    
    public func addUser(user: User) async throws -> User {
        try await sendRequest(for: FakeStoreUserEndpoints.addNewUser(user: user))
    }
    
    public func updateUser(id: Int, user: User) async throws -> User {
        try await sendRequest(for: FakeStoreUserEndpoints.updateUser(userId: id, user: user))
    }
    
    public func deleteUser(id: Int) async throws -> User {
        try await sendRequest(for: FakeStoreUserEndpoints.deleteUser(userId: id))
    }
    
}
