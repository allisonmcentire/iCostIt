//
//  RollUpTableViewCell.swift
//  iCostIt
//
//  Created by Allison Mcentire on 7/25/17.
//  Copyright © 2017 com.millionacrenest. All rights reserved.
//

import UIKit

class RollUpTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var calcType: UILabel!
   
    @IBOutlet weak var calcResults: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
