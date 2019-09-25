//
//  OrderListTblViewCell.swift
//  HomeMade2
//
//  Created by Afrah Tayyab on 6/28/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

protocol SellerOrderDetailItemCellDelegate : class {
    func onClick_status(object : SellerOrder)
}

class SellerOrderDetailItemCell: UITableViewCell {

    //MARK: Outlets fro Data allocation.
    @IBOutlet weak var img_prodctImg: UIImageView!
    @IBOutlet weak var lbl_productTitle: UILabel!
    
    @IBOutlet weak var lbl_quantityTitle: UILabel!
    @IBOutlet weak var lbl_quantity: UILabel!
    @IBOutlet weak var lbl_storeName: UILabel!
    @IBOutlet weak var lbl_amount: UILabel!
//    @IBOutlet weak var lbl_quantity: UILabel!
    weak var delegate : SellerOrderDetailItemCellDelegate?
    weak var object : SellerOrder?
    
    @IBOutlet weak var btn_productStatus: UIButton!
    
    //MARK: For Localization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func loadCell(object : SellerOrder){
        self.object = object
        img_prodctImg.kf.setImage(with: URL(string: object.image ?? ""), placeholder:  PlaceHolder.hms_placeHolder_medium)
        lbl_quantity.text = "\(object.quantity ?? 1)"
        lbl_amount.text = object.total?.showPrice?.formattedText
        lbl_storeName.text = object.store?.storeName
        
        
        switch object.status {
        case "confirmed":
            enableButton(title: "SHIP ORDER".localized)
        case "cancelled":
            disableButton(title: "CANCELLED".localized)
        case "shipped":
            disableButton(title: "SHIPPED".localized)
        case "completed":
            disableButton(title: "COMPLETED".localized)
        default:
            print("No statment execudted")
        }
//        btn_productStatus.setTitle(object.status?.capitalized, for: .normal)
    }
    func disableButton(title : String){
        btn_productStatus.isEnabled = false
        btn_productStatus.backgroundColor = .lightGray
        btn_productStatus.setTitleColor(.darkGray, for: .normal)
        btn_productStatus.setTitle(title, for: .normal)
    }
    func enableButton(title : String){
        btn_productStatus.isEnabled = true
        btn_productStatus.backgroundColor = #colorLiteral(red: 0.9710801244, green: 0.6898229718, blue: 0.2214611471, alpha: 1)
        btn_productStatus.setTitleColor(.white, for: .normal)
        btn_productStatus.setTitle(title, for: .normal)
    }
    @IBAction func onClick_status(_ sender: Any) {
        delegate?.onClick_status(object: object!)
    }
    
}
