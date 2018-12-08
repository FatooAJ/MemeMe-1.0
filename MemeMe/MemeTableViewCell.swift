//
//  MemeTableViewCell.swift
//  MemeMe
//
//  Created by Fatima ALjaber on 11/21/18.
//  Copyright © 2018 Fatima ALjaber. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {

    @IBOutlet weak var memeTextLabel: UILabel!
    @IBOutlet weak var sentMemeImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
