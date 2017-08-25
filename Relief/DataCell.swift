//
//  DataCell.swift
//  Relief
//
//  Created by New on 7/3/17.
//  Copyright © 2017 HSI. All rights reserved.
//

import UIKit
import Firebase

class DataCell: UITableViewCell {

    @IBOutlet weak var venueLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!

    var post: venueData!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(post: venueData) {
        self.venueLbl.text = post.locationName
        self.addressLbl.text = post.address
        
    }

}
