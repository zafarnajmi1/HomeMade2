//
//  ProductDetailOptionBaseCell.swift
//  HomeMade2
//
//  Created by Apple on 20/06/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit


protocol ProductDetailOptionDelegate : class{
    func featureSelected(object : Priceables1, charactistic : Characteristic, index : Int)
}
extension ProductDetailOptionDelegate{
//    func featureSelected(object : Priceables1, charactistic : Characteristic, indexPath : IndexPath){
//        print("Default Implementation is called.")
//    }

    
}
class ProductDetailOptionBaseCell: UITableViewCell {
    
    var priceable : Priceables1?
    weak var delegate : ProductDetailOptionDelegate?

//    var indexPath : IndexPath?
    @IBOutlet weak var lbl_title : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func loadCell(object : Priceables1, delegate : ProductDetailOptionDelegate?){
//        self.combinations = combinationList
        priceable = object
        self.delegate = delegate
        lbl_title.text = object.feature?.title
//        self.indexPath = indexPath
//        if let store = productDetails?.store{
//            lbl_storeName.text = store.storeName
//            
//            //            lbl_storeLocation.text = store.storeName
//            img_store.kf.setImage(with: URL(string: store.image ?? ""), placeholder: AppConstant.placeHolders.image)
//        }
//        lbl_description.text = productDetails?.description
//        lbl_storeLocation.text = productDetails?.address
        
        //        lbl_description.text = productDetails
        
    }
    func loadDataInCell(object : Priceables1, delegate : ProductDetailOptionDelegate?, combinationIDs : [String]?){
//        self.combinations = combinationList
        priceable = object
        self.delegate = delegate
        lbl_title.text = object.feature?.title
//        self.indexPath = indexPath
        //        if let store = productDetails?.store{
        //            lbl_storeName.text = store.storeName
        //
        //            //            lbl_storeLocation.text = store.storeName
        //            img_store.kf.setImage(with: URL(string: store.image ?? ""), placeholder: AppConstant.placeHolders.image)
        //        }
        //        lbl_description.text = productDetails?.description
        //        lbl_storeLocation.text = productDetails?.address
        
        //        lbl_description.text = productDetails
        
    }

}
