//
//  AddressTableViewCell.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 21/06/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {

    @IBOutlet weak var imageHome: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var address2: UILabel!
    @IBOutlet weak var cepBairro: UILabel!
    @IBOutlet weak var cityState: UILabel!
    @IBOutlet weak var roundedView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
