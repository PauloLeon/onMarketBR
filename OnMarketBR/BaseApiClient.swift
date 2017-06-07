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
        
        static let domainName  = "http://dev.onmarketbr.com.br/"
        
        static let apiPathName = "api/v1"
        
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
                case .home:  return "/taxonomies"
                default: return ""
            }
        }
        
        // MARK: - Parameters
        var parameters: URLRequestParams? {
            var params: URLRequestParams?
            
            let token = "6ce6956bb25541def91e19d5b745bfd826a0153d0034e7ea"
            
            if params == nil {
                params = ["token" : token]
            } else {
                params!["token"] = token
            }
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

