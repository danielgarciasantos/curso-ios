//
//  TableViewCellUser.swift
//  trabalhoFinal
//
//  Created by Daniel Garcia on 01/12/2017.
//  Copyright © 2017 Daniel Garcia. All rights reserved.
//

import UIKit

class TableViewCellUser: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var detail: UILabel!
    
    override func awakeFromNib() {
        img?.clipsToBounds = true
        img!.layer.cornerRadius = 10
        img.layer.borderColor = UIColor.brown.cgColor
        img?.layer.borderWidth = 1.0
        img?.contentMode = .scaleAspectFit
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
