//
//  TaskTableViewCell.swift
//  TodoDocker
//
//  Created by Daniel Garcia on 07/12/2017.
//  Copyright © 2017 Daniel Garcia. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptionn: UILabel!
    @IBOutlet weak var expirationDate: UILabel!
    @IBOutlet weak var imgComplete: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
