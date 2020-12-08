//
//  InteraccionesCell.swift
//  BloodMed
//
//  Created by Kenny Cardenas Reyes on 10/24/20.
//  Copyright © 2020 Kenny Cardenas Reyes. All rights reserved.
//

import UIKit

class InteraccionesCell: UITableViewCell {
    
    @IBOutlet weak var interactionTitle: UILabel!

    @IBOutlet weak var interactionDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
