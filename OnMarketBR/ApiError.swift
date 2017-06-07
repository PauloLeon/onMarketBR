//
//  ApiError.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 07/06/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import Alamofire
import SwiftyJSON

class ApiError {
    var response: HTTPURLResponse?
    var json: JSON?
    
    init(response: DataResponse<Any>) {
        self.response = response.response
        
        if let data = response.data {
            self.json = JSON(data: data)
        }
    }
    
    func errorMessage() -> String {
        var errorMessage = ""
        
        print("***** Error: ")
        print(response ?? "response nil")
        
        if let errors = json?["errors"] , errors.count != 0 {
            for (field, messages):(String, JSON) in errors {
                let key = field.titleize
                
                for message in messages.arrayValue {
                    errorMessage += "\(key) \(message.stringValue)\n"
                }
            }
        } else if let message = json?["message"] , !message.isEmpty {
            errorMessage = message.stringValue
        } else {
            errorMessage = "Some error occurred. Please try again."
        }
        
        return errorMessage
    }
    
}


