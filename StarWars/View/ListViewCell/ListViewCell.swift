//
//  ListViewCell.swift
//  StarWars
//
//  Created by Vishwa Fernando on 2022-11-21.
//

import UIKit

class ListViewCell: UITableViewCell {
    
    @IBOutlet weak var lb_planetName: UILabel!
    @IBOutlet weak var lb_climate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
