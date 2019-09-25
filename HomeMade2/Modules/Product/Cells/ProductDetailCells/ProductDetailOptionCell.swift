//
//  ProductDetailOptionCell.swift
//  HomeMade2
//
//  Created by Apple on 19/06/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class ProductDetailOptionCell: UICollectionViewCell {
    
    @IBOutlet weak var img_option : UIImageView!
    @IBOutlet weak var img_selection : UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        img_option.layer.cornerRadius = 5.0
        img_option.clipsToBounds = true
        // Initialization code
    }

}
