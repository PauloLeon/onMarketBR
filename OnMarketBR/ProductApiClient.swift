//
//  ProductApiClient.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 14/06/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ProductApiClient: BaseApiClient {

    static func products(_ data: URLRequestParams, success: @escaping ([Product]) -> Void, failure: @escaping (ApiError) -> Void ) {
        Alamofire.request(Router.products(data: data))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    let json = JSON(data: response.data!)
                    
                    var products = [Product]()
                    for productJSON in json["products"].arrayValue {
                        let product = Product(fromJSON: productJSON)
                        products.append(product)
                    }
                    
                    success(products)
                case .failure(_):
                    let apiError = ApiError(response: response)
                    failure(apiError)
                }
        }
    }

}
