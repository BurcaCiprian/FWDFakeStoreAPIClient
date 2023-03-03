//
//  FakeStoreUserEndpointsTests.swift
//  
//
//  Created by Burca Victor Ciprian on 03.03.2023.
//

import XCTest
@testable import FWDNetworkingLibrary
@testable import FWDFakeStoreAPIClient

class FakeStoreUserEndpointsTests: XCTestCase {
    
    // MARK: - Test Cases
    
    func testGetAllUsersEndpoint() {
        // given
        let endpoint = FakeStoreUserEndpoints.getAllUsers(limit: 10, sort: "id")
        
        // then
        XCTAssertEqual(endpoint.path, "/users")
        XCTAssertEqual(endpoint.method, .get)
        XCTAssertEqual(endpoint.queryItems?.count, 2)
        XCTAssertEqual(endpoint.queryItems?[QueryItemKey.limit.rawValue], "10")
        XCTAssertEqual(endpoint.queryItems?[QueryItemKey.sort.rawValue], "id")
        XCTAssertEqual(endpoint.headers, TestConstants.DEFAULT_HEADERS)
        XCTAssertNil(endpoint.body)
    }
    
    func testGetAllUsersEndpointWithoutSort() {
        // given
        let endpoint = FakeStoreUserEndpoints.getAllUsers(limit: 10, sort: nil)
        
        // then
        XCTAssertEqual(endpoint.path, "/users")
        XCTAssertEqual(endpoint.method, .get)
        XCTAssertEqual(endpoint.queryItems?.count, 1)
        XCTAssertEqual(endpoint.queryItems?[QueryItemKey.limit.rawValue], "10")
        XCTAssertNil(endpoint.queryItems?[QueryItemKey.sort.rawValue])
        XCTAssertEqual(endpoint.headers, TestConstants.DEFAULT_HEADERS)
        XCTAssertNil(endpoint.body)
    }
    
    func testGetAllUsersEndpointWithNoLimit() {
        // given
        let endpoint = FakeStoreUserEndpoints.getAllUsers(limit: nil, sort: "id")
        
        // then
        XCTAssertEqual(endpoint.path, "/users")
        XCTAssertEqual(endpoint.method, .get)
        XCTAssertEqual(endpoint.queryItems?.count, 1)
        XCTAssertEqual(endpoint.queryItems?[QueryItemKey.sort.rawValue], "id")
        XCTAssertEqual(endpoint.headers, TestConstants.DEFAULT_HEADERS)
        XCTAssertNil(endpoint.body)
    }
    func testGetAllUsersEndpointWithoutLimitAndSort() {
        // given
        let endpoint = FakeStoreUserEndpoints.getAllUsers(limit: nil, sort: nil)
        
        // then
        XCTAssertEqual(endpoint.path, "/users")
        XCTAssertEqual(endpoint.method, .get)
        XCTAssertNil(endpoint.queryItems)
        XCTAssertEqual(endpoint.headers, TestConstants.DEFAULT_HEADERS)
        XCTAssertNil(endpoint.body)
    }
    
    func testGetSingleUserEndpoint() {
        // given
        let userId = 1
        let endpoint = FakeStoreUserEndpoints.getSingleUser(userId: userId)
        
        // then
        XCTAssertEqual(endpoint.path, "/users/\(userId)")
        XCTAssertEqual(endpoint.method, .get)
        XCTAssertNil(endpoint.queryItems)
        XCTAssertEqual(endpoint.headers, TestConstants.DEFAULT_HEADERS)
        XCTAssertNil(endpoint.body)
    }
    
    func testAddNewUserEndpoint() {
        // given
        let user = generateMockUser()
        let endpoint = FakeStoreUserEndpoints.addNewUser(user: user)
        
        // then
        XCTAssertEqual(endpoint.path, "/users")
        XCTAssertEqual(endpoint.method, .post)
        XCTAssertNil(endpoint.queryItems)
        XCTAssertEqual(endpoint.headers, TestConstants.DEFAULT_HEADERS)
        XCTAssertNotNil(endpoint.body)
        XCTAssertEqual(endpoint.body?.count, 7)
        XCTAssertEqual(endpoint.body?["username"] as? String, user.username)
    }
    
    func testUpdateUserEndpoint() {
        // given
        let userId = 1
        let user = generateMockUser()
        let endpoint = FakeStoreUserEndpoints.updateUser(userId: userId, user: user)
        
        // then
        XCTAssertEqual(endpoint.path, "/users/\(userId)")
        XCTAssertEqual(endpoint.method, .put)
        XCTAssertNil(endpoint.queryItems)
        XCTAssertEqual(endpoint.headers, TestConstants.DEFAULT_HEADERS)
        XCTAssertNotNil(endpoint.body)
        XCTAssertEqual(endpoint.body?.count, 7)
        XCTAssertEqual(endpoint.body?["username"] as? String, user.username)
    }
    
    func testDeleteUserEndpoint() {
        // given
        let userId = 1
        let endpoint = FakeStoreUserEndpoints.deleteUser(userId: userId)
        
        // then
        XCTAssertEqual(endpoint.path, "/users/\(userId)")
        XCTAssertEqual(endpoint.method, .delete)
        XCTAssertNil(endpoint.queryItems)
        XCTAssertEqual(endpoint.headers, TestConstants.DEFAULT_HEADERS)
        XCTAssertNil(endpoint.body)
    }
}

extension FakeStoreUserEndpointsTests {
    private func generateMockUser() -> User {
        let mockAddress = Address(street: "123 Main St", city: "Suite 1", state: "Testville", zip: "12345-6789", geo: GeoLocation(lat: "-37.3159", lng: "81.1496"))
        let mockCompany = Company(name: "Test Company", catchPhrase: "Testing the limits", bs: "Just testing")
        return User(id: 1, username: "testuser", email: "testuser@example.com", address: mockAddress, phone: "555-1234", website: "example.com", company: mockCompany)
    }
}
