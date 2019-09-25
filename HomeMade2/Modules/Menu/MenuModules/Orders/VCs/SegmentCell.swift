//
//  SegmentCell.swift
//  HomeMade2
//
//  Created by Apple on 12/07/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class SegmentCell: UICollectionViewCell {

    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var img_bg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadCell(object: SegmentObject) {
        if let count = object.itemCount{
            lbl_title.text = "\(object.title)(\(count))"
        }
        else{
            lbl_title.text = object.title
        }
        if object.isSelected {
            img_bg.isHidden = false
            lbl_title.textColor = .white
        }
        else{
            img_bg.isHidden = true
            lbl_title.textColor = .black
        }
        
    }
    

}
