//
//  APIConstants.swift
//  MSDMasterDetail
//
//  Created by Michael San Diego on 5/12/20.
//  Copyright © 2020 Michael San Diego. All rights reserved.
//

import Foundation

public enum NetworkEnvironment {
    static var BASE_URL: String {
        return "https://itunes.apple.com"
    }
}

//The header fields
enum HTTPHeaderField: String {
    case contentType = "Content-Type"
    case acceptType = "Accept"
}

//The content type (JSON)
enum ContentType: String {
    case json = "application/json"
}
