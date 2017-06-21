//
//  PinkTableViewCell.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 21/06/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import UIKit

class PinkTableViewCell: UITableViewCell {

    @IBOutlet weak var labelInfo: UILabel!
    @IBOutlet weak var onmarketIcon: UIImageView!
    @IBOutlet weak var labelDrag: UILabel!
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
