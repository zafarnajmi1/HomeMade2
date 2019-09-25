//
//  ProductListingCell.swift
//  HomeMade2
//
//  Created by Apple on 14/06/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit


protocol ProductListingCellDelegate: class {
    func onClick_addToCart(product : BaseProduct)
    func onClick_like(product : BaseProduct)
    func onClick_share(product : BaseProduct)
}
extension ProductListingCellDelegate{
    func onClick_addToCart(product : BaseProduct){
        
    }
    func onClick_like(product : BaseProduct){
        
    }
    func onClick_share(product : BaseProduct){
        
    }
}

class ProductListingCell: UICollectionViewCell {
    
    @IBOutlet weak var img_image: UIImageView!
    
    @IBOutlet weak var btn_addToCart: UIButton!
    @IBOutlet weak var btn_share: UIButton!
    @IBOutlet weak var btn_like: UIButton!
    
    @IBOutlet weak var uv_stockView: UIView!
    @IBOutlet weak var lbl_inStock: UILabel!
    @IBOutlet weak var lbl_quantity: UILabel!
    @IBOutlet weak var lbl_price: UILabel!
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var lbl_storeName: UILabel!
    @IBOutlet weak var lbl_location: UILabel!
    weak var product : BaseProduct?
    weak var delegate : ProductListingCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        roundButton(btn: btn_share)
        roundButton(btn: btn_like)
        roundButton(btn: btn_addToCart)
        
//        let viewBorder = CAShapeLayer()
//        viewBorder.strokeColor = UIColor.lightGray.cgColor
//        viewBorder.fillColor = nil
//        viewBorder.lineDashPattern = [4,2]
//        viewBorder.path = UIBezierPath(rect: uv_stockView.bounds).cgPath
//        viewBorder.frame = uv_stockView.bounds
//        uv_stockView.layer.addSublayer(viewBorder)
        
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = #colorLiteral(red: 0.9294117647, green: 0.9333333333, blue: 0.937254902, alpha: 1)
        
        
        
        
        // Initialization code
    }
    
    func loadCell(object : BaseProduct)  {
        product = object
        
        img_image.kf.setImage(with: URL(string: object.image ?? ""), placeholder: PlaceHolder.hms_placeHolder_medium)
        lbl_title.text = object.title
        lbl_price.text = object.price?.showPrice?.formattedText
        lbl_quantity.text = "\(object.available ?? 0)"
        lbl_storeName.text = object.store?.storeName
        lbl_location.text = object.address
        
        if let fav = object.isFavorite{
            btn_like.setImage(UIImage(named: (fav ? "heart_filled_list":"heart_empty_list")), for: .normal)
        }
        
        
    }
    
    func roundButton(btn : UIButton)  {
        btn.layer.cornerRadius = btn.frame.height/2
        btn.borderColor = .white
        btn.borderWidth = 2.0
        btn.clipsToBounds = true
    }
    @IBAction func onClick_cart(_ sender: Any) {
        if let product = product{
            delegate?.onClick_addToCart(product: product)
        }
        
    }
    @IBAction func onClick_share(_ sender: Any) {
        if let product = product{
            delegate?.onClick_share(product: product)
        }
        
    }
    @IBAction func onClick_like(_ sender: Any) {
        if let product = product{
            delegate?.onClick_like(product: product)
        }
        

       
        
//        delegate?.onClick_like()
    }
}
