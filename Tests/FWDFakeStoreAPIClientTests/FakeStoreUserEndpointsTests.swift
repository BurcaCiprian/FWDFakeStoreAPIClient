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
        XCTAssertEqual(endpoint.body?.count, 8)
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
        XCTAssertEqual(endpoint.body?.count, 8)
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
        
        let companyMock = Company(
            name: "Acme Inc.",
            catchPhrase: "The best company around",
            bs: "Making the world a better place"
        )
        
        let geoLocationMock = GeoLocation(lat: "37.7749", long: "-122.4194")
        
        let addressMock = Address(geolocation: geoLocationMock, city: "Brasov", street: "Some street", number: 54, zipcode: "123123")
        
        let mockName = User.Name(firstname: "John", lastname: "Doe")
        
        let mockUser = User(id: 1, username: "username", email: "username@gmail.com", address: addressMock, phone: "123123", website: "www.google.com", company: companyMock, name: mockName)
        return mockUser
    }
}
