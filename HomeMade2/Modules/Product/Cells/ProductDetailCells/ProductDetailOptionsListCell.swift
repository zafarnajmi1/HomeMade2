//
//  ProductDetailSelectionCell.swift
//  HomeMade2
//
//  Created by Apple on 19/06/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class ProductDetailOptionsListCell: ProductDetailOptionBaseCell {
    
//    @IBOutlet weak var lbl_title : UILabel!
    @IBOutlet weak var clv_options : UICollectionView!
//    weak var priceable : Priceables?

    override func awakeFromNib() {
        super.awakeFromNib()
        clv_options.delegate = self
        clv_options.dataSource = self
        clv_options.register(ProductDetailOptionCell.nib, forCellWithReuseIdentifier: ProductDetailOptionCell.className)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func loadCell(object : Priceables1, delegate : ProductDetailOptionDelegate?) {
        super.loadCell(object: object, delegate: delegate)
        clv_options.reloadData()
    }
//    func loadCell(object: Priceables) {
//        priceable = object
//        lbl_title.text = priceable?.feature?.title
//
//    }
    
}
extension ProductDetailOptionsListCell : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return priceable?.characteristics?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductDetailOptionCell.className, for: indexPath) as? ProductDetailOptionCell
            else{
                return UICollectionViewCell()
        }
        if priceable?.selectedIndex == indexPath.row{
            cell.img_selection.isHidden = false
        }
        else{
            cell.img_selection.isHidden = true
        }
        if let chart = priceable?.characteristics?[indexPath.row]{
            cell.img_option.kf.setImage(with: URL(string: chart.image ?? ""), placeholder: PlaceHolder.hms_placeHolder_small)
            
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let row = priceable?.selectedIndex{
            if priceable?.selectedIndex != indexPath.row{
                if let cell = collectionView.cellForItem(at: IndexPath(item: row, section: 0)) as? ProductDetailOptionCell
                {
                    cell.img_selection.isHidden = true
                }
            }
           
            
        }
        priceable?.selectedIndex = indexPath.row
        if let cell = collectionView.cellForItem(at: indexPath) as? ProductDetailOptionCell
        {
            cell.img_selection.isHidden = false
//            priceable?.selectedIndex = row
            let charact = priceable?.characteristics?[indexPath.row]
            delegate?.featureSelected(object: priceable!, charactistic: charact!, index: indexPath.row)
//            delegate?.featureSelected(object: priceable?.feature, charactistic: charact, indexPath: IndexPath)
        }
        
        
    }
    
    
}
