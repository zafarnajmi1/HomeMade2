//
//  ProductDetailBottomCell.swift
//  HomeMadeSupplier2
//
//  Created by Afrah Tayyab on 6/18/19.
//  Copyright © 2019 Afrah Tayyab. All rights reserved.
//

import UIKit

class ProductDetailBottomCell: UITableViewCell {
    @IBOutlet weak var img_store: UIImageView!
    @IBOutlet weak var lbl_storeName: UILabel!
    @IBOutlet weak var lbl_storeLocation: UILabel!
    @IBOutlet weak var lbl_descriptionTitle: UILabel!
    @IBOutlet weak var lbl_description: UILabel!
    weak var productDetails : ProductDetail?

    override func awakeFromNib() {
        super.awakeFromNib()
        img_store.layer.cornerRadius = img_store.frame.width/2
        img_store.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func loadCell(object : ProductDetail){
        productDetails = object
        if let store = productDetails?.store{
            lbl_storeName.text = store.storeName
            
//            lbl_storeLocation.text = store.storeName
             img_store.kf.setImage(with: URL(string: store.image ?? ""), placeholder: PlaceHolder.hms_placeHolder_small)
        }
        lbl_description.text = productDetails?.description
        lbl_storeLocation.text = productDetails?.address
        
//        lbl_description.text = productDetails
        
    }
    
}
