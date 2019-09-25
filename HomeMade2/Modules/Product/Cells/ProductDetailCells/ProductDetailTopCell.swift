//
//  ProductDetailTopCell.swift
//  HomeMade2
//
//  Created by Apple on 20/06/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
protocol ProductDetailTopCellDelegate : class{
    func onClick_resetSection()
}
class ProductDetailTopCell: UITableViewCell {
    @IBOutlet weak var clv_gallary : UICollectionView!
    @IBOutlet weak var upc_gallary : UIPageControl!
    
    @IBOutlet weak var lbl_stockTitle : UILabel!
    @IBOutlet weak var lbl_stock : UILabel!
    @IBOutlet weak var lbl_price : UILabel!
    @IBOutlet weak var lbl_productName : UILabel!
    @IBOutlet weak var lbl_categories : UILabel!
    
    weak var productDetails : ProductDetail?
    weak var selectedCombination : Combination?
    var imagesList : [ImageObject] = []
    weak var delegate : ProductDetailTopCellDelegate?
    
    //    @IBOutlet weak var clv_options : UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clv_gallary.register(PreviewImageCell.nib, forCellWithReuseIdentifier: PreviewImageCell.className)
        
        
        let layout = clv_gallary.collectionViewLayout as! UICollectionViewFlowLayout
        
        //        let screenWidth = UIScreen.main.bounds.size.width
        //        let screenHeight = UIScreen.main.bounds.size.height
        let itemWidth = AppSettings.screenWidth
        let itemHeight = itemWidth * (934/1080)
        layout.scrollDirection = .horizontal
        
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight-1)
        clv_gallary.collectionViewLayout = layout
        clv_gallary.delegate = self
        clv_gallary.dataSource = self
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        // Configure the view for the selected state
    }
    func loadCell(object : ProductDetail, combination : Combination?) {
        productDetails = object
        self.selectedCombination = combination
        lbl_productName.text = productDetails?.title
        var catText = ""
        if productDetails?.categories?.count ?? 0 == 2{
            catText = "\(productDetails?.categories?[0].title ?? ""): \(productDetails?.categories?[1].title ?? "")"
        }
        if productDetails?.categories?.count ?? 0 == 1{
            catText = "\(productDetails?.categories?[0].title ?? "")"
        }
        lbl_categories.text = catText
        
        if let _ = combination{
            loadCellWithCombination()
        }
        else{
            loadCellWithDetails()
        }
        
        upc_gallary.numberOfPages = imagesList.count
        clv_gallary.reloadData()
        
//        lbl_price.text = productDetails?.price?.usd?.formattedAmount
//        lbl_stock.text = "\(productDetails?.available ?? 0)"
        
   
        
        
    }
    func loadCellWithDetails(){
        imagesList = productDetails?.images ?? []
        lbl_price.text = productDetails?.price?.showPrice?.formattedText
//        lbl_stock.text = "\(productDetails?.available ?? 0)"
    }
    func loadCellWithCombination(){
        imagesList = selectedCombination?.images ?? []
        lbl_price.text = selectedCombination?.price?.showPrice?.formattedText
//        lbl_price.text = selectedCombination?.price?.usd?.formattedAmount
        lbl_stock.text = "\(selectedCombination?.available ?? 0)"
    }
    
    @IBAction func onClick_pager(_ sender: UIPageControl) {
        let page = sender.currentPage
        clv_gallary.scrollToPage(index: page, animated: true, after: 0)
    }
    @IBAction func onClick_resetSection(_ sender: Any) {
        delegate?.onClick_resetSection()
    }
    
}
extension ProductDetailTopCell : UIScrollViewDelegate{
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        print("Image Preview DidEndScrollingAnimation")
        previewEndScrolling()
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        perform(#selector(scrollViewDidEndScrollingAnimation(_:)), with: nil, afterDelay: 0.3)
        print("Image Preview ScrollViewDidScroll")
    }
    func previewEndScrolling() {
        let page = clv_gallary.contentOffset.x / clv_gallary.frame.width
        upc_gallary.currentPage = Int(page)
        
        
    }
    
    //    -(void)scrollViewDidScroll:(UIScrollView *)sender
    //    {
    //    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    //    //ensure that the end of scroll is fired.
    //    [self performSelector:@selector(scrollViewDidEndScrollingAnimation:) withObject:sender afterDelay:0.3];
    //
    //    ...
    //    }
    //
    //    -(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
    //    {
    //    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    //    ...
    //    }
}
extension ProductDetailTopCell : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if let productDetails = productDetails{
            return imagesList.count
//        }
//        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PreviewImageCell.className, for: indexPath) as? PreviewImageCell
            else{
                return UICollectionViewCell()
        }
//        if let productDetails = productDetails{
//            let images = productDetails.images ?? []
            let image = imagesList[indexPath.row]
            cell.img_image.kf.setImage(with: URL(string: image.path ?? ""), placeholder: PlaceHolder.hms_placeHolder_large)
//        }
        
        
        return cell
    }
    
    
}
