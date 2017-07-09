//
//  UserApiClient.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 21/06/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class UserApiClient: BaseApiClient {

    static func signin(_ data: URLRequestParams, success: @escaping (User) -> Void, failure: @escaping (ApiError) -> Void ){
            var data = URLRequestParams()
            data["email"] = "test2@test.com"
            data["password"] = "123456"        
            Alamofire.request(Router.login(data: data))
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        let json = JSON(data: response.data!)
                        success(User(fromJSON: json))
                    case .failure(_):
                        let apiError = ApiError(response: response)
                        failure(apiError)
                    }
            }

    }
    
    static func signup(_ data: URLRequestParams, success: @escaping (JSON) -> Void, failure: @escaping (ApiError) -> Void){
        Alamofire.request(Router.signup(data: data))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    let json = JSON(data: response.data!)
                    success(json)
                case .failure(_):
                    let apiError = ApiError(response: response)
                    failure(apiError)
                }
        }
    }
    
    static func forgotPassword(_ data: URLRequestParams, success: @escaping (JSON) -> Void, failure: @escaping (ApiError) -> Void){
        Alamofire.request(Router.forgotPassword(data: data))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    let json = JSON(data: response.data!)
                    success(json)
                case .failure(_):
                    let apiError = ApiError(response: response)
                    failure(apiError)
                }
        }
    }
}
