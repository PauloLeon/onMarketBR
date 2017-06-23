//
//  TaxonomiesViewModels.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 23/06/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import UIKit

public final class TaxonomiesViewModels {

    public let taxonomies: Taxonomies
    public let lblCategorias: String!

    
    public init(taxonomies: Taxonomies){
        self.taxonomies = taxonomies
        self.lblCategorias = self.taxonomies.name
    }
}
