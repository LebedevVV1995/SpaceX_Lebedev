//
//  MyTableViewCell.swift
//  SpaceX_Lebedev
//
//  Created by Владимир on 13/07/2019.
//  Copyright © 2019 Владимир. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var mission_path: UIImageView!
    @IBOutlet weak var mission_name: UILabel!
    @IBOutlet weak var mission_date: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
