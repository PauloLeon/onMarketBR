//
//  DefaultTableViewCell.swift
//  OnMarketBR
//
//  Created by Paulo Rosa on 26/06/17.
//  Copyright © 2017 OnMarket. All rights reserved.
//

import UIKit

class DefaultTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var notinRegisterLabel: UILabel!
    @IBOutlet weak var arrasteLabel: UILabel!
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
