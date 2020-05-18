//
//  APIRouter.swift
//  MSDMasterDetail
//
//  Created by Michael San Diego on 5/12/20.
//  Copyright © 2020 Michael San Diego. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouterNetwork: URLRequestConvertible {
    
    case getItunesSearch
    
    var mainURL: String  {
        return NetworkEnvironment.BASE_URL
    }
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .getItunesSearch:
            return "/search"
        }
    }
    
    // MARK: - URL Components
    private var url:URL {
        var urlComponents = URLComponents(string: NetworkEnvironment.BASE_URL)!
        urlComponents.path = path
        
        switch self {
        case .getItunesSearch:
            urlComponents.queryItems = [
                URLQueryItem(name: "term", value: "star"),
                URLQueryItem(name: "country", value: "au"),
                URLQueryItem(name: "media", value: "movie"),
                URLQueryItem(name: "all", value: "")
            ]
            return urlComponents.url!
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        default:
            return nil
        }
    }
    
    // MARK: - URLRquestBuilder
    private var urlRequestBuilder: URLRequest {
        
        var urlRequestBuilder = URLRequest(url: url)
        
        urlRequestBuilder.httpMethod = method.rawValue
        
        // Common Headers
        urlRequestBuilder.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        urlRequestBuilder.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        
        
        switch self {
        default:
           return urlRequestBuilder
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        
        var urlRequest = urlRequestBuilder
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters)
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        return urlRequest
    }
}
