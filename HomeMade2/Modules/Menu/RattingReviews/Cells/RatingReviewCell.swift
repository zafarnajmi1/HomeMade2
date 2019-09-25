//
//  RatingReviewTableViewCell.swift
//  TailerOnline
//
//  Created by apple on 3/12/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import UIKit
import Cosmos

class RatingReviewCell: UITableViewCell {

     //MARK:-  outlets
    @IBOutlet weak var img_image: UIImageView!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var lbl_review: UILabel!
    @IBOutlet weak var lbl_timeAgo: UILabel!
    @IBOutlet weak var cosm_stars: CosmosView!
    @IBOutlet weak var lbl_ratting: UILabel!

     //MARK:-  my life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }


//    func setData(model: Review)  {
//       let url = model.user?.image?.resizeImage(width: 200, height: 200)
//       myImage.setPath(image: url, placeHolder: AppConstant.placeHolders.user)
//       myTitle.text = model.user?.fullName
//       myDetail.text = model.comment
//       stars.rating = model.rating ?? 0
//       ratingNumber.text = "(\(model.ratingStr))"
//       timeAgo.text = setTimeAgoFormatBy(dateString: model.createdAt!)
//       
//    }
    func loadCell(object : StoreReview){
        if let user = object.user{
            img_image.kf.setImage(with: URL(string: user.image ?? ""), placeholder: PlaceHolder.hms_placeHolder_small)
            lbl_name.text = "\(user.firstName ?? "") \(user.lastName ?? "")"
            
        }
        cosm_stars.rating = object.rating ?? 0.0
        lbl_review.text = object.comment
        lbl_ratting.text = "\(object.rating ?? 0.0)"
        lbl_timeAgo.text = Date.DateAgo(from: object.createdAt ?? "")
        
    }
    
}
