//
//  MapStoreCell.swift
//  HomeMade2
//
//  Created by Apple on 03/07/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import Cosmos
class MapStoreCell: UICollectionViewCell {
    
    
    @IBOutlet weak var img_storeImage: UIImageView!
    @IBOutlet weak var lbl_storeName: UILabel!
    @IBOutlet weak var lbl_address: UILabel!
    @IBOutlet weak var lbl_rating: UILabel!
    @IBOutlet weak var cosv_rating: CosmosView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var store : ListStore?
    
    func loadCell(object : ListStore){
        store = object
        img_storeImage.kf.setImage(with: URL(string: object.image ?? ""), placeholder: PlaceHolder.hms_placeHolder_medium)
        lbl_storeName.text = object.storeName
        lbl_address.text = object.address
        cosv_rating.rating = object.averageRating ?? 0
        lbl_rating.text = "\(object.averageRating ?? 0)"
    }

}
