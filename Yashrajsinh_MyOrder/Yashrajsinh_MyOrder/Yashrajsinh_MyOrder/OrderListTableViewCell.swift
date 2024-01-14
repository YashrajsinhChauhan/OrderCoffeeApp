//
//  OrderListTableViewCell.swift
//  Yashrajsinh_MyOrder
//
//  Created by user217595 on 5/16/22.
//

import UIKit

class OrderListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var coffeeType: UILabel!
    
    @IBOutlet weak var coffeSize: UILabel!
    
    @IBOutlet weak var quantity: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
