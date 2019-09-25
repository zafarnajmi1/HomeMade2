//
//  SellerOrderHeaderCell.swift
//  HomeMade2
//
//  Created by Apple on 03/07/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class SellerOrderHeaderCell: UITableViewCell {
    
    

    @IBOutlet weak var img_user: UIImageView!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var lbl_phone: UILabel!
    @IBOutlet weak var lbl_email: UILabel!
    
    @IBOutlet weak var lbl_billingAddressTitle: UILabel!
    @IBOutlet weak var lbl_billingAddress: UILabel!
    @IBOutlet weak var lbl_shippingAddressTitle: UILabel!
    @IBOutlet weak var lbl_shippingAddress: UILabel!
    
    weak var object : SellerOrder?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lbl_shippingAddressTitle.text = "Shipping Address".localized
        lbl_billingAddressTitle.text = "Billing Address".localized
        img_user.layer.cornerRadius = img_user.frame.width/2
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCell(object : SellerOrder){
        self.object = object
        if let user = object.order?.user{
            img_user.kf.setImage(with: URL(string: user.image ?? ""), placeholder:  PlaceHolder.hms_placeHolder_medium)
            lbl_name.text = "\(user.firstName ?? "") \(user.lastName ?? "")"
            lbl_email.text = user.email
            lbl_phone.text = user.phone
        }
        let addresses = object.order?.addresses ?? []
        if !addresses.isEmpty{
            
            let billing = addresses[0]
            let shipping = addresses[1]
            lbl_billingAddress.text = "\(billing.address1 ?? "")\n\(billing.address2 ?? "")"
            lbl_shippingAddress.text = "\(shipping.address1 ?? "")\n\(shipping.address2 ?? "")"
        }
    }
    
}
