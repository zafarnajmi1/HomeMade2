//
//  RateSupplierCell.swift
//  HomeMade2
//
//  Created by Apple on 08/07/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import Cosmos

protocol RateSupplierCellDelegate : class {
    func onClick_send()
}

class RateSupplierCell: UITableViewCell {

    
    
    
    @IBOutlet weak var lbl_rateTitle: UILabel!
    
    @IBOutlet weak var txt_comment: UITextField!
    @IBOutlet weak var lbl_reviewsTitle: UILabel!
    @IBOutlet weak var btn_send: UIButton!
    @IBOutlet weak var cosm_ratting: CosmosView!
    weak var review : Review?
    
    
    weak var delegate: RateSupplierCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lbl_rateTitle.text = "Rate Supplier".localized
        lbl_reviewsTitle.text = "Reviews".localized
        txt_comment.placeholder = "Write your review here".localized
        txt_comment.addleftRightPading(right: 50)
        txt_comment.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        cosm_ratting.didFinishTouchingCosmos =  { [weak self] rating in
            print("Did touched")
//            self?.review?.isRatting = true
            self?.review?.rating = rating
        }
        
        
        // Initialization code
    }

    func loadCell(object : Review){
        review = object
        txt_comment.text = object.comment
        cosm_ratting.rating = Double(object.rating)
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func onClick_send(_ sender: Any) {
        delegate.onClick_send()
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        review?.comment = textField.text!
    }
    
}
