//
//  CartCell.swift
//  HomeMade2
//
//  Created by Apple on 21/06/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit


protocol CartCellDelegate : class {
    func deleteItem(object : CartItem?)
    func selectItem(object : CartItem?)
    func updateItem(object : CartItem?, quantity : Int)
}
extension CartCellDelegate{
    func deleteItem(object : CartItem?){
        
    }
    func selectItem(object : CartItem?){
        
    }
    func updateItem(object : CartItem?, quantity : Int){
        
    }
}
class CartCell: UITableViewCell {
    
    @IBOutlet weak var img_image: UIImageView!
    
    
    @IBOutlet weak var btn_delete: UIButton!
    @IBOutlet weak var btn_minus: UIButton!
    @IBOutlet weak var btn_plus: UIButton!
    
    @IBOutlet weak var lbl_productName: UILabel!
    @IBOutlet weak var lbl_totalPrice: UILabel!
    @IBOutlet weak var lbl_singlePrice: UILabel!
    @IBOutlet weak var lbl_storeName: UILabel!
    @IBOutlet weak var lbl_quantity: UILabel!
    weak var object : CartItem?
    weak var delegate : CartCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        img_image.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageSelected))
        img_image.addGestureRecognizer(tapGesture)
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCell(object : CartItem, delegate : CartCellDelegate) {
        self.object = object
        self.delegate = delegate
        img_image.kf.setImage(with: URL(string: object.image ?? ""), placeholder:  PlaceHolder.hms_placeHolder_medium)
        lbl_productName.text = object.product?.title
        lbl_storeName.text = object.product?.store?.storeName
        lbl_quantity.text = "\(object.quantity ?? 0)"
        lbl_singlePrice.text = object.price?.showPrice?.formattedText
        lbl_totalPrice.text = object.total?.showPrice?.formattedText
        
    }
    
    @IBAction func onClick_minus(_ sender: Any) {
        if object?.quantity == 1{
            UIViewController.topVC()?.alertMessage(message: "You can not decrease quantity from one".localized, completion: {
                
            })
        }
        else{
            
            updateProduct(quantity: (object?.quantity ?? 1) - 1)
        }
        
    }
    @IBAction func onClick_plus(_ sender: Any) {
//        if object?.product
        updateProduct(quantity: (object?.quantity ?? 1) + 1)
    }
    @objc @IBAction func imageSelected(){
        self.delegate?.selectItem(object: object)
    }
    func updateProduct(quantity : Int){
        self.delegate?.updateItem(object: object, quantity: quantity)
//        let alert = UIAlertController(title: "Delete".localized, message: "Are you sure you want to delete this item from cart?".localized, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: { (action) in
//            
//        }))
//        alert.addAction(UIAlertAction(title: "Delete".localized, style: .destructive, handler: { [weak self] (action) in
//            self?.delegate?.deleteItem(object: self?.object)
//        }))
//        UIViewController.topVC()?.present(alert, animated: true, completion: {
//            
//        })
    }
    
    @IBAction func onClick_delete(_ sender: Any) {
        let alert = UIAlertController(title: "Delete".localized, message: "Are you sure you want to delete this item from cart?".localized, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: { (action) in
            
        }))
        alert.addAction(UIAlertAction(title: "Delete".localized, style: .destructive, handler: { [weak self] (action) in
            self?.delegate?.deleteItem(object: self?.object)
        }))
        UIViewController.topVC()?.present(alert, animated: true, completion: {
            
        })
    }
    
}
