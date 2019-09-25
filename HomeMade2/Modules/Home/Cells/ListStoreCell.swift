//
//  StoresCollectionViewCell.swift
//  HomeMade2
//
//  Created by Afrah Tayyab on 6/25/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import Cosmos

class ListStoreCell: UICollectionViewCell {

    
    @IBOutlet weak var viewBackGroundView: UIView!{
        didSet{
            self.viewBackGroundView.layer.borderWidth = 1
            self.viewBackGroundView.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        }
    }
    @IBOutlet weak var cosm_rating: CosmosView!
    @IBOutlet weak var img_profie: UIImageView!
    @IBOutlet weak var lbl_rating: UILabel!
    @IBOutlet weak var lbl_address: UILabel!
    @IBOutlet weak var lbl_storeName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func loadCell(object: ListStore) {
        img_profie.kf.setImage(with: URL(string: object.image ?? ""), placeholder: PlaceHolder.hms_placeHolder_medium)
        lbl_storeName.text = object.storeName
        lbl_address.text = object.address
        lbl_rating.text = "\(object.averageRating ?? 0.0)"
        cosm_rating.rating = object.averageRating ?? 0
    }

}
