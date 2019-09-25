//
//  StoreReviewCell.swift
//  HomeMade2
//
//  Created by Apple on 08/07/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import Cosmos

protocol StoreReviewCellDelegate : class {
    
}

class StoreReviewCell: UITableViewCell {

    @IBOutlet weak var img_user: UIImageView!
    @IBOutlet weak var lbl_user: UILabel!
    @IBOutlet weak var cosm_ratting: CosmosView!
    @IBOutlet weak var lbl_review: UILabel!
    @IBOutlet weak var lbl_date: UILabel!
    
    var review : StoreReview?
    weak var delegate: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCell(object : StoreReview){
        review = object
        img_user.kf.setImage(with: URL(string: object.user?.image ?? ""), placeholder: PlaceHolder.hms_placeHolder_small)
        lbl_review.text = object.comment
        lbl_user.text = "\(object.user?.firstName ?? "") \(object.user?.lastName ?? "")"
        cosm_ratting.rating = object.rating ?? 0.0
        lbl_date.text = Date.showDate(from: object.createdAt ?? "")
    }
    
}
