//
//  ReceivedImageCell.swift
//  HomeMade2
//
//  Created by Apple on 09/07/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class ReceivedImageCell: ReceivedCell {

    @IBOutlet weak var img_image : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func loadCell(message: Message, listObject: ListConversation) {
        super.loadCell(message: message, listObject: listObject)
        img_image.kf.setImage(with: URL(string: message.content ?? ""), placeholder: PlaceHolder.hms_placeHolder_medium)
    }
//    override func loadCell(message: Message) {
//        super.loadCell(message: message)
//        
//    }
}
