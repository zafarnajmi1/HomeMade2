//
//  ConfirmedOrderTblCell.swift
//  HomeMade2
//
//  Created by Afrah Tayyab on 6/27/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class ConfirmedOrderTblCell: UITableViewCell {

    //MARK: Outlets for Data.
    @IBOutlet weak var img_OrderImg: UIImageView!
    @IBOutlet weak var lbl_orderNumber: UILabel!
    @IBOutlet weak var lbl_TotalNoProducts: UILabel!
   
    @IBOutlet weak var lbl_OrderDate: UILabel!
    @IBOutlet weak var lbl_PendingOrders: UILabel!
    @IBOutlet weak var lbl_DeliveredOrders: UILabel!
    @IBOutlet weak var lbl_OrderAmount: UILabel!
    
    //MARK: For Localization
    @IBOutlet weak var lbl_orderRefNumber: UILabel!
    @IBOutlet weak var lbl_TotalProducts: UILabel!
    
    @IBOutlet weak var lbl_Date: UILabel!
    @IBOutlet weak var lbl_Status: UILabel!
    @IBOutlet weak var lbl_Pending: UILabel!
    @IBOutlet weak var lbl_Delivered: UILabel!
    @IBOutlet weak var lbl_Amount: UILabel!
    @IBOutlet weak var btn_View: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
