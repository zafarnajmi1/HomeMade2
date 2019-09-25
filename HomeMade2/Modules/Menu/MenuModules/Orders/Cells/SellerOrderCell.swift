//
//  ConfirmedOrderTblCell.swift
//  HomeMade2
//
//  Created by Afrah Tayyab on 6/27/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit


class SellerOrderCell: UITableViewCell {

    //MARK: Outlets for Data.
    
    @IBOutlet weak var btn_detail: UIButton!
    @IBOutlet weak var img_OrderImg: UIImageView!
//    @IBOutlet weak var lbl_orderNumberTitle: UILabel!
    @IBOutlet weak var lbl_productTitle: UILabel!
    
    
    
    @IBOutlet weak var lbl_totalProductsTitle: UILabel!
    @IBOutlet weak var lbl_totalProducts: UILabel!
    
    @IBOutlet weak var lbl_dateTitle: UILabel!
    @IBOutlet weak var lbl_date: UILabel!
    
    @IBOutlet weak var lbl_statusTitle: UILabel!
    @IBOutlet weak var lbl_status: UILabel!
    
//    @IBOutlet weak var lbl_pendingTitle: UILabel!
//    @IBOutlet weak var lbl_pending: UILabel!
//    @IBOutlet weak var lbl_deliveredTitle: UILabel!
//    @IBOutlet weak var lbl_delivered: UILabel!

    @IBOutlet weak var lbl_amount: UILabel!
    @IBOutlet weak var lbl_amountTitle: UILabel!
    
    @IBOutlet weak var img_moreItemsIcon: UIImageView!
    
    weak var sellerOrder : SellerOrder?
    weak var delegate : SellerOrderDetailVCDelegate?
    
    
    //MARK: For Localization
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btn_detail.layer.cornerRadius = btn_detail.frame.width/2
        
        // Initialization code
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

    func loadCell(object : SellerOrder){
        sellerOrder = object
        img_OrderImg.kf.setImage(with: URL(string: object.image ?? ""), placeholder:  PlaceHolder.hms_placeHolder_medium)
        //        img_OrderImg.kf.setImage(with: URL(string: object.image ?? ""), placeholder:  PlaceHolder.hms_placeHolder_medium)
        lbl_amount.text = object.total?.showPrice?.formattedText
        lbl_productTitle.text = object.product?.title
        lbl_date.text = Date.showDate(from: object.createdAt ?? "NA")
        lbl_status.text = object.status
        lbl_totalProducts.text = "\(object.quantity ?? 1)"
        img_moreItemsIcon.isHidden = (object.quantity ?? 1) == 1
        
    }
    @IBAction func onClick_detail(_ sender: Any) {
        let vc = SellerOrderDetailVC.viewController()
        vc.order = sellerOrder
        vc.delegate = delegate
        BaseNavVC.currentNav().pushViewController(vc, animated: true)
        
    }
    
}
