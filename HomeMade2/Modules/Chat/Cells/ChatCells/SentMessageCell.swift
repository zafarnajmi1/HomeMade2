//
//  SentMessageCell.swift
//  HomeMade2
//
//  Created by Apple on 09/07/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class SentMessageCell: SentCell {
    
    @IBOutlet weak var lbl_message : UILabel!

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
        
        
        lbl_message.text = message.content
    }
    
}
