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
        
        case orders
        case updateOrder(id: String, data: URLRequestParams)
        case createOrder(data: URLRequestParams)

        case cart
        case addItem(order_id: String, data: URLRequestParams)
        case updateItem(order_id: String, item_id: Int, data: URLRequestParams)
        case removeItem(order_id: String, item_id: Int)
        
        case products(data: URLRequestParams)


        
        // MARK: - Methods
        var method: HTTPMethod {
            switch self {
                case .addItem, .createOrder:
                    return .post
                case .removeItem:
                    return .delete
                case .updateItem:
                    return .patch
                default:
                    return .get
                }
        }
        
        // MARK: - Paths
        var path: String {
            switch self {
                case .home:  return "/taxonomies"
                case .orders: return "/orders"
                case .cart: return "/orders/current"
                case .updateOrder(let id, _):                                   return "/orders/\(id)"
                case .addItem(let order_id, _):                                 return "/orders/\(order_id)/line_items"
                case .updateItem(let order_id, let item_id, _):                 return "/orders/\(order_id)/line_items/\(item_id)"
                case .removeItem(let order_id, let item_id):                    return "/orders/\(order_id)/line_items/\(item_id)"
                case .products(_):                                              return "/products"
                case .createOrder(_):                                           return "/orders/"

            }
        }
        
        // MARK: - Parameters
        var parameters: URLRequestParams? {
            var params: URLRequestParams?
            
            switch self {
                case .updateOrder(_, let data):             params = data
                case .addItem(_, let data):                 params = data
                case .updateItem(_, _, let data):           params = data
                case .products(let data):                   params = data
                case .createOrder(let data):                params = data
                default:                                    params = nil
            }
            
            if User.isLoggedIn {
                let token = User.currentUser!.token!
                
                if params == nil {
                    params = ["token" : token]
                } else {
                    params!["token"] = token
                }
            }else if Guest.exists{
                let token = Guest.currentGuest!.tokenGuest!
                
                if params == nil {
                    params = ["token" : token]
                } else {
                    params!["token"] = token
                }      
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

