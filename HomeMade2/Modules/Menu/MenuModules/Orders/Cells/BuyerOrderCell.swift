//
//  ConfirmedOrderTblCell.swift
//  HomeMade2
//
//  Created by Afrah Tayyab on 6/27/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit


class BuyerOrderCell: UITableViewCell {

    //MARK: Outlets for Data.
    
    @IBOutlet weak var btn_detail: UIButton!
    @IBOutlet weak var img_OrderImg: UIImageView!
    @IBOutlet weak var lbl_orderNumberTitle: UILabel!
    @IBOutlet weak var lbl_orderNumber: UILabel!
    
    
    
    @IBOutlet weak var lbl_totalProductsTitle: UILabel!
    @IBOutlet weak var lbl_totalProducts: UILabel!
    
    @IBOutlet weak var lbl_dateTitle: UILabel!
    @IBOutlet weak var lbl_date: UILabel!
    
    @IBOutlet weak var lbl_statusTitle: UILabel!
    @IBOutlet weak var lbl_status: UILabel!
    @IBOutlet weak var lbl_amount: UILabel!
    @IBOutlet weak var lbl_amountTitle: UILabel!
    
    @IBOutlet weak var img_moreItemsIcon: UIImageView!
    
    weak var orderItem : BuyerOrder?
    weak var delegate : BuyerOrderDetailVCDelegate?
    
    //MARK: For Localization
    override func awakeFromNib() {
        super.awakeFromNib()
        btn_detail.layer.cornerRadius = btn_detail.frame.width/2
        
        // Initialization code
    }



    func loadCell(object : BuyerOrder){
        orderItem = object
        if let orderDetail = object.orderDetails{
            if orderDetail.count > 0{
                img_OrderImg.kf.setImage(with: URL(string: orderDetail[0].image ?? ""), placeholder:  PlaceHolder.hms_placeHolder_medium)
            }
            else{
                 img_OrderImg.image = PlaceHolder.hms_placeHolder_medium
            }
        }
        else{
            img_OrderImg.image = PlaceHolder.hms_placeHolder_medium
        }
        
        
//        img_OrderImg.kf.setImage(with: URL(string: object.image ?? ""), placeholder:  PlaceHolder.hms_placeHolder_medium)
        lbl_amount.text = object.total?.showPrice?.formattedText
        lbl_orderNumber.text = object.orderNumber
        lbl_date.text = Date.showDate(from: object.createdAt ?? "NA")
        lbl_status.text = object.statusString
        lbl_totalProducts.text = "\(object.orderDetails?.count ?? 0)"
        
        img_moreItemsIcon.isHidden = (object.orderDetails?.count ?? 0) == 1
        
    }
    /*
    func loadSellerCell(object : SellerOrder){
        sellerOrder = object
        img_OrderImg.kf.setImage(with: URL(string: object.image), placeholder:  PlaceHolder.hms_placeHolder_medium)
        //        img_OrderImg.kf.setImage(with: URL(string: object.image ?? ""), placeholder:  PlaceHolder.hms_placeHolder_medium)
        lbl_amount.text = object.total?.showPrice?.formattedText
        lbl_orderNumber.text = object.order._id
        lbl_date.text = Date.showDate(from: object.createdAt ?? "NA")
        lbl_status.text = object.statusString
        lbl_totalProducts.text = "\(object.orderDetails?.count ?? 0)"
        
        img_moreItemsIcon.isHidden = (object.orderDetails?.count ?? 0) == 1
        
    }
 */
    @IBAction func onClick_detail(_ sender: Any) {
        let vc = BuyerOrderDetailVC.viewController()
        vc.order = orderItem
        vc.delegate = delegate
        BaseNavVC.currentNav().pushViewController(vc, animated: true)
    }
    
}
