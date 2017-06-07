//
//  BaseApiClient.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 07/06/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import UIKit
import Alamofire

typealias URLRequestParams = [String: Any]

class BaseApiClient {
    
}

extension BaseApiClient {
    enum Router: URLRequestConvertible {
        
        static let domainName  = "http://shop-spree.herokuapp.com"
        
        static let apiPathName = "api/ams"
        
        static let baseURLString = "\(domainName)/\(apiPathName)"
        
        // MARK: - Routes
        case home
        
        // MARK: - Methods
        var method: HTTPMethod {
            switch self {
                default:
                    return .get
                }
        }
        
        // MARK: - Paths
        var path: String {
            switch self {
                case .home:  return "/home"
                default: return ""
            }
        }
        
        // MARK: - Parameters
        var parameters: URLRequestParams? {
            var params: URLRequestParams?
            return params
        }
        
        func asURLRequest() throws -> URLRequest {
            let url = try Router.baseURLString.asURL()
            
            var urlRequest = URLRequest(url: url.appendingPathComponent(path))
            urlRequest.httpMethod = method.rawValue
            
            if let parameters = parameters {
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            }
            
            print("*** \(urlRequest)")
            
            return urlRequest
        }
        
    }
}

