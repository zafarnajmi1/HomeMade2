//
//  BaseChatCell.swift
//  HomeMade2
//
//  Created by Apple on 09/07/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class BaseChatCell: UITableViewCell {

    @IBOutlet weak var lbl_time : UILabel!
    var message : Message?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func loadCell(message : Message){
        self.message = message
        lbl_time.text = Date.DateAgo(from: message.createdAt ?? "")
    }
}

class SentCell: BaseChatCell {
    
    
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
        
    }
    
}

class ReceivedCell: BaseChatCell {
    @IBOutlet weak var img_sender : UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func loadCell(message: Message, listObject :ListConversation) {
        loadCell(message: message)
        var imageURL = ""
        if loggedInUserAccountType == .seller
        {
            imageURL = listObject.user?.image ?? ""
        }
        else{
            imageURL = listObject.store?.image ?? ""
        }
        img_sender.kf.setImage(with: URL(string: imageURL), placeholder: PlaceHolder.hms_placeHolder_small)
        
    }
}
