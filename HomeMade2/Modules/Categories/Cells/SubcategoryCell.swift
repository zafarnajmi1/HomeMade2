//
//  SubcategoryCell.swift
//  HomeMade2
//
//  Created by Apple on 13/06/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class SubcategoryCell: UITableViewCell {

    
    @IBOutlet weak var lbl_name : UILabel!
    @IBOutlet weak var img_bottomLine : UIImageView!
    @IBOutlet weak var img_bottomWhite : UIImageView!
    @IBOutlet weak var img_leftLine : UIImageView!
    @IBOutlet weak var img_rightLine : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        img_leftLine.layer.shadowOffset = CGSize(width: 10, height: 10)
        img_leftLine.layer.shadowRadius = 1
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//    static var nib:UINib{
//        return UINib(nibName: self.className, bundle: nil)
//    }
    func loadCell(object : Subcategory){
    
        lbl_name.text = object.title
    
    }
    func setBottomShadow(value : Bool){
        if value {
            img_bottomLine.isHidden = false
            img_bottomWhite.isHidden = false
            
            
        }
        else{
            img_bottomLine.isHidden = true
            img_bottomWhite.isHidden = true
        }
    }
    
    
    
}



