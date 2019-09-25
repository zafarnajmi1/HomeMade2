//
//  StoreDetailHeaderCell.swift
//  HomeMade2
//
//  Created by Apple on 08/07/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import Cosmos
class StoreDetailHeaderCell: UITableViewCell {

    @IBOutlet weak var img_store: UIImageView!
    @IBOutlet weak var cosm_rating: CosmosView!
    @IBOutlet weak var lbl_ratting: UILabel!
    
    @IBOutlet weak var lbl_storeName: UILabel!
    
    @IBOutlet weak var lbl_address: UILabel!
    @IBOutlet weak var lbl_descriptionTitle: UILabel!
    
    @IBOutlet weak var lbl_description: UILabel!
    var storeDetail : StoreDetail?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lbl_descriptionTitle.text = "About Supplier".localized
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func loadCell(object : StoreDetail){
        self.storeDetail = object
        img_store.kf.setImage(with: URL(string: object.image ?? ""), placeholder: PlaceHolder.hms_placeHolder_large)
        lbl_storeName.text = object.storeName
        lbl_address.text = object.address
        lbl_description.text = object.description
        lbl_ratting.text = "\(object.averageRating ?? 0.0)"
        cosm_rating.rating = object.averageRating ?? 0.0
        
    }
}
