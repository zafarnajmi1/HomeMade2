//
//  RatingReviewTableViewCell.swift
//  TailerOnline
//
//  Created by apple on 3/12/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import UIKit
import Cosmos

class RatingReviewTableViewCell: UITableViewCell {

     //MARK:-  outlets
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myTitle: UILabel!
    @IBOutlet weak var myDetail: UILabel!
    @IBOutlet weak var timeAgo: UILabel!
    @IBOutlet weak var stars: CosmosView!
    @IBOutlet weak var ratingNumber: UILabel!

     //MARK:-  my life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }


    func setData(model: ReviewModel)  {
       
        myImage.kf.setImage(with: URL(string: model.user!.image!), placeholder: AppConstant.placeHolders.user)
       
       myTitle.text = model.user?.fullName
       myDetail.text = model.comment
       stars.rating = model.rating ?? 0
       ratingNumber.text = model.ratingStr
        timeAgo.text = setTimeAgoFormatBy(dateString: model.createdAt!)
       
    }
    
}
