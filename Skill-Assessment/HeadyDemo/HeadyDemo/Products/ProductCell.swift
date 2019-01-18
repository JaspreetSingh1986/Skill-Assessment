//
//  ProductCell.swift
//  HeadyDemo
//
//  Created by Jaspreet on 16/01/19.
//  Copyright © 2019 Jaspreet. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
