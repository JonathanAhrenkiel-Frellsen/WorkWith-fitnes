//
//  FindPartnerTableViewCell.swift
//  KomITEksamen
//
//  Created by Jonathans Macbook Pro on 24/04/2017.
//  Copyright © 2017 skycode. All rights reserved.
//

import UIKit

class FindPartnerTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
