//
//  FakeStoreEndpoint.swift
//  
//
//  Created by Burca Victor Ciprian on 01.03.2023.
//

import FWDNetworkingLibrary

public protocol FakeStoreEndpointType: EndpointType {}

public extension FakeStoreEndpointType {
    var scheme: String {
        return "https"
    }
    
    var user: String? {
        return nil
    }
    
    var password: String? {
        return nil
    }
    
    var port: Int? {
        return nil
    }
    
    var fragment: String? {
        return nil
    }
    
    var host: String {
        return "fakestoreapi.com"
    }
    
    var body: [String : String]? {
        return nil
    }
}
