//
//  TaxonomiesApiClient.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 07/06/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TaxonomiesApiClient: BaseApiClient {
    
    static func getTaxonomies(_ success: @escaping ([Taxonomies]) -> Void, failure: @escaping (ApiError) -> Void ){
        Alamofire.request(Router.home)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    let json = JSON(data: response.data!)
                    var taxonomies = [Taxonomies]()
                    let tax = json["taxonomies"]
                    for cardJSON in tax.arrayValue {
                        let card = Taxonomies(fromJSON: cardJSON)
                        taxonomies.append(card)
                    }
                    success(taxonomies)
                case .failure(_):
                    let apiError = ApiError(response: response)
                    failure(apiError)
                }
        }
    }
}
