//
//  NotificationTableViewCell.swift
//  HomeMade2
//
//  Created by Afrah Tayyab on 6/24/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

protocol NotificationCellDelegate : class {
    func removeNotification(object : Notification)
}


class NotificationCell: UITableViewCell {

    
    @IBOutlet weak var img_notificationImage: UIImageView!
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var lbl_body: UILabel!
    @IBOutlet weak var lbl_time: UILabel!
    @IBOutlet weak var btn_cross: UIButton!
    @IBOutlet weak var img_seen: UIImageView!
    
    weak var object : Notification?
    
    weak var delegate: NotificationCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func onClick_cross(_ sender: Any) {
        delegate?.removeNotification(object: object!)
    }
    func loadCell(object : Notification){
        self.object = object
        if let image = object.sender?.image{
            img_notificationImage.kf.setImage(with: URL(string: image), placeholder: PlaceHolder.hms_placeHolder_small)
        }
        else{
            img_notificationImage.image = PlaceHolder.hms_placeHolder_small
        }
        
        lbl_time.text = Date.DateAgo(from: object.createdAt ?? "")
        lbl_title.text = object.title
        lbl_body.text = object.description
        img_seen.isHidden = object.seen ?? true
        
        
    }
}
