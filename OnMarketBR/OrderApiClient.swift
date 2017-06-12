//
//  OrderApiClient.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 11/06/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON

class OrderApiClient: BaseApiClient {
    
    static func orders(_ success: @escaping ([Order]) -> Void, failure: @escaping (ApiError) -> Void ) {
        Alamofire.request(Router.orders)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    let json = JSON(data: response.data!)
                    var orders = [Order]()
                    for orderJSON in json["orders"].arrayValue {
                        let order = Order(fromJSON: orderJSON)
                        orders.append(order)
                    }
                    success(orders)
                case .failure(_):
                    let apiError = ApiError(response: response)
                    failure(apiError)
                }
        }
    }
    
    static func current(_ success: @escaping (Order) -> Void, failure: @escaping (ApiError) -> Void ) {
        Alamofire.request(Router.cart)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    let json = JSON(data: response.data!)
                    let order = Order(fromJSON: json)
                    
                    Order.currentOrder = order
                    
                    success(order)
                case .failure(_):
                    let apiError = ApiError(response: response)
                    failure(apiError)
                }
        }
    }
}
