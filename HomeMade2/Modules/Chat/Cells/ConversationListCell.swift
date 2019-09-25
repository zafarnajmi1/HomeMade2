//
//  ConversationListCell.swift
//  HomeMade2
//
//  Created by Apple on 09/07/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class ConversationListCell: UITableViewCell {

    @IBOutlet weak var img_image: UIImageView!
    @IBOutlet weak var lbl_productName: UILabel!
    @IBOutlet weak var lbl_userName: UILabel!
    @IBOutlet weak var lbl_lastMessage: UILabel!
    @IBOutlet weak var lbl_price: UILabel!
    @IBOutlet weak var lbl_date: UILabel!
    var object : ListConversation?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func loadCell(object : ListConversation){
        self.object = object
        
        img_image.kf.setImage(with: URL(string: object.store?.image ?? ""), placeholder: PlaceHolder.hms_placeHolder_small)
        lbl_productName.text = object.product?.title
        lbl_price.text = object.product?.price?.showPrice?.formattedText
        lbl_userName.text = "\(object.user?.firstName ?? "") \(object.user?.lastName ?? "")"
        lbl_date.text = Date.DateAgo(from: object.createdAt ?? "")
        if object.lastMessage?.mimeType == "text"{
            lbl_lastMessage.text = object.lastMessage?.content
        }
        else{
            lbl_lastMessage.text = "image/jpeg"//object.lastMessage?.content
        }
        
        
        
        
        
    }
}
