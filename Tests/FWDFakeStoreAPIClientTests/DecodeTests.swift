//
//  DecodeTests.swift
//  
//
//  Created by Burca Victor Ciprian on 05.03.2023.
//

import XCTest
@testable import FWDFakeStoreAPIClient
@testable import FWDNetworkingLibrary

class DecodeTests: XCTestCase {
    
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
    
    func testUserDecode() throws {
        // Given
        let json = """
            {
                "id": 1,
                "username": "johndoe",
                "email": "john.doe@example.com",
                "name": {
                    "firstname": "John",
                    "lastname": "Doe"
                },
                "address": {
                    "geolocation": {
                        "lat": "37.7749",
                        "long": "-122.4194"
                    },
                    "city": "San Francisco",
                    "street": "Market St",
                    "number": 123,
                    "zipcode": "94102"
                },
                "phone": "555-555-1212",
                "website": "example.com",
                "company": {
                    "name": "Example, Inc.",
                    "catchPhrase": "A catchphrase goes here.",
                    "bs": "A BS goes here."
                }
            }
            """.data(using: .utf8)!
        // When
        let user: User = try userService.decode(json, for: 200)
        
        // Then
        XCTAssertEqual(user.id, 1)
        XCTAssertEqual(user.username, "johndoe")
        XCTAssertEqual(user.email, "john.doe@example.com")
        XCTAssertEqual(user.phone, "555-555-1212")
        XCTAssertEqual(user.website, "example.com")
        XCTAssertEqual(user.name?.firstname, "John")
        XCTAssertEqual(user.name?.lastname, "Doe")
        XCTAssertEqual(user.address?.city, "San Francisco")
        XCTAssertEqual(user.address?.street, "Market St")
        XCTAssertEqual(user.address?.number, 123)
        XCTAssertEqual(user.address?.zipcode, "94102")
        XCTAssertEqual(user.address?.geolocation.lat, "37.7749")
        XCTAssertEqual(user.address?.geolocation.long, "-122.4194")
    }
    
    func testDecodeUserFailure() {
        let data = Data()
        do {
            let _: User = try userService.decode(data, for: 404)
            XCTFail("Expected decoding to throw an error")
        } catch let error as APIError {
            switch error {
            case .notFound(let response):
                XCTAssertNil(response)
            default:
                XCTFail("Expected notFound error")
            }
        } catch {
            XCTFail("Expected APIError")
        }
    }
    
    func testDecodeAddressSuccess() throws {
        let json = """
        {
            "geolocation": {
                "lat": "37.7749",
                "long": "-122.4194"
            },
            "city": "San Francisco",
            "street": "Market St",
            "number": 100,
            "zipcode": "94103"
        }
        """.data(using: .utf8)!
        
        let address: Address = try userService.decode(json, for: 200)
        
        XCTAssertEqual(address.city, "San Francisco")
        XCTAssertEqual(address.street, "Market St")
        XCTAssertEqual(address.number, 100)
        XCTAssertEqual(address.zipcode, "94103")
        XCTAssertEqual(address.geolocation.lat, "37.7749")
        XCTAssertEqual(address.geolocation.long, "-122.4194")
    }
    
    func testDecodeAddressFailure() throws {
        let json = """
        {
            "city": 111,
            "street": "Market St",
            "number": 100,
            "zipcode": "94103"
        }
        """.data(using: .utf8)!
        
        do {
            let _: Address = try userService.decode(json, for: 200)
        } catch   {
            XCTAssertNotNil(error)
        }
        
    }
    
    func testDecodeGeoLocationSuccess() throws {
        let json = """
        {
            "lat": "37.7749",
            "long": "-122.4194"
        }
        """.data(using: .utf8)!
        
        let location: GeoLocation = try userService.decode(json, for: 200)
        
        XCTAssertEqual(location.lat, "37.7749")
        XCTAssertEqual(location.long, "-122.4194")
    }
    
    func testDecodeProductSuccess() throws {
        // Given
        let json = """
            {
                "id": 123,
                "title": "Example product",
                "price": 9.99,
                "description": "An example product",
                "category": "Example category",
                "image": "https://example.com/product.jpg"
            }
            """.data(using: .utf8)!
        
        // When
        let product: Product = try userService.decode(json, for: 200)
        
        // Then
        XCTAssertEqual(product.id, 123)
        XCTAssertEqual(product.title, "Example product")
        XCTAssertEqual(product.price, 9.99)
        XCTAssertEqual(product.description, "An example product")
        XCTAssertEqual(product.category, "Example category")
        XCTAssertEqual(product.image, "https://example.com/product.jpg")
    }
    
}
