//
//  TableViewCellArtista.swift
//  trabalhoFinal
//
//  Created by Daniel Garcia on 01/12/2017.
//  Copyright © 2017 Daniel Garcia. All rights reserved.
//

import UIKit

class TableViewCellArtista: UITableViewCell {
    
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subscription: UILabel!
    
    override func awakeFromNib() {
        img?.clipsToBounds = true
        img!.layer.cornerRadius = 50
        img?.contentMode = .scaleAspectFit
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(TableViewCellArtista.tapFunction))
        subscription.isUserInteractionEnabled = true
        subscription.addGestureRecognizer(tap)
    
        super.awakeFromNib()
        // Initialization code
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        UIApplication.shared.open(URL(string: subscription.text!)!, options: [:], completionHandler: nil)
        print(subscription.text!)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
