//
//  SentImageCell.swift
//  HomeMade2
//
//  Created by Apple on 09/07/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class SentImageCell: SentCell {

    @IBOutlet weak var img_image : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func loadCell(message: Message) {
        super.loadCell(message: message)
        img_image.kf.setImage(with: URL(string: message.content ?? ""), placeholder: PlaceHolder.hms_placeHolder_medium)
    }
}
