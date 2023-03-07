//
//  UserServiceTests.swift
//  
//
//  Created by Burca Victor Ciprian on 04.03.2023.
//

import XCTest
@testable import FWDFakeStoreAPIClient

class UserServiceTests: XCTestCase {
    
    // MARK: - Properties
    
    var userService: UserService!
    
    // MARK: - Set Up & Tear Down
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        userService = UserService()
    }
    
    override func tearDownWithError() throws {
        userService = nil
        try super.tearDownWithError()
    }
    
    // MARK: - Tests
    
    func testGetAllUsers() async throws {
        let limit = 10
        let sort = "desc"
        let users = try await userService.getAllUsers(limit: limit, sort: sort)
        XCTAssertNotNil(users)
        XCTAssertEqual(users.count, limit)
    }
    
    func testGetUser() async throws {
        let userId = 1
        let user = try await userService.getUser(id: userId)
        XCTAssertNotNil(user)
        XCTAssertEqual(user.id, userId)
    }
    
    func testAddUser() async throws {
        // Given
        let newUser = User(id: 1,
                           username: "john_doe",
                           email: "john_doe@gmail.com",
                           address: Address(
                            geolocation: GeoLocation(lat: "40.758896",
                                                     long: "-73.985130"),
                            city: "New York",
                            street: "Broadway",
                            number: 123,
                            zipcode: "10001"
                           ),
                           phone: "123-456-7890",
                           website: "johndoe.com",
                           company: Company(name: "Acme Inc",
                                            catchPhrase: "Making everything possible",
                                            bs: "Some fancy business stuff"), name: User.Name(firstname: "aaa", lastname: "bbb"))
        
        // When
        let addedUser = try await userService.addUser(user: newUser)
        
        // Then
        XCTAssertNotNil(addedUser)
        
    }
    
    func testUpdateUser() async throws {
        // Create a mock user to update
        // Mock Address
        let mockAddress = Address(
            geolocation: GeoLocation(lat: "37.773972", long: "-122.431297"),
            city: "San Francisco",
            street: "Market St",
            number: 1234,
            zipcode: "94103"
        )
        
        // Mock Company
        let mockCompany = Company(
            name: "Acme Inc.",
            catchPhrase: "We make the best widgets",
            bs: "Delivering quality since 1980"
        )
        
        let mockName = User.Name(firstname: "John", lastname: "Doe")
        
        let userId = 1
            
        // Define the updated user
        let updatedUser = User(id: userId, username: "johndoe2", email: "johndoe2@example.com", address: mockAddress, phone: "987-654-3210", website: "https://johndoe2.com", company: mockCompany, name: mockName)
        
       
        // Make the request
        let result = try await userService.updateUser(id: userId, user: updatedUser)
        
        // Verify the result
        XCTAssertNotNil(result)

    }
    
    func testDeleteUser() async throws {
        // Make the request
        let result = try await userService.deleteUser(id: 1)
        
        // Verify the result
        XCTAssertNotNil(result)

    }
    
}
