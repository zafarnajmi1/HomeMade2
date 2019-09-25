//
//  MenuItemCell.swift
//  HomeMade2
//
//  Created by Apple on 24/05/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class MenuItemCell: UITableViewCell {

    @IBOutlet weak var img_image: UIImageView!
    @IBOutlet weak var lbl_title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func loadCell(item : MenuItem){
        img_image.image = UIImage(named: item.image)
        lbl_title.text = item.title
        
    }
    
}
