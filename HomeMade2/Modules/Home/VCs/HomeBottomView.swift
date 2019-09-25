//
//  HomeBottomCollection.swift
//  HomeMade2
//
//  Created by Apple on 04/07/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit


protocol HomeBottomViewDelegate : class {
    func itemScrolled(lastIndex : Int, index: Int)
}

class HomeBottomView: UIView {
    
    @IBOutlet weak var lbl_noData: UILabel!
     @IBOutlet weak var clv_stores: UICollectionView!
    @IBOutlet weak var btn_left: UIButton!
    @IBOutlet weak var btn_right: UIButton!
    var lastIndex : Int = -1
    var currentIndex : Int = -1
    var isCurrentLocation : Bool = false
    weak var delegate: HomeBottomViewDelegate?
    
    private var storesList : [ListStore] = []
    
    var stores : [ListStore]{
        set {
            storesList = newValue
            clv_stores.reloadData()
            
            if storesList.isEmpty {
                updateButtons(index: -1)
                lbl_noData.isHidden = false
            }
            else{
                clv_stores.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: false)
                lbl_noData.isHidden = true
                lastIndex = 0
                currentIndex = 0
                updateButtons(index: currentIndex)
            }
            
        }
        get{
            return storesList
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lbl_noData.text = "No Data Available".localized
        clv_stores.register(MapStoreCell.nib, forCellWithReuseIdentifier: MapStoreCell.className)
        clv_stores.delegate = self
        clv_stores.dataSource = self
        clv_stores.isPagingEnabled = true
        
        btn_left.setImage(UIImage(named: "arrow_previous_grey"), for: .disabled)
        btn_right.setImage(UIImage(named: "arrow_next_grey"), for: .disabled)
        let itemWidth = AppSettings.screenWidth-100
        let itemHeight : CGFloat = 90.0
        let layout = clv_stores.collectionViewLayout as! UICollectionViewFlowLayout
        
        //        let screenWidth = UIScreen.main.bounds.size.width
        //        let screenHeight = UIScreen.main.bounds.size.height
//        let itemWidth = AppSettings.screenWidth
//        let itemHeight = itemWidth * (934/1080)
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight-1)
        clv_stores.collectionViewLayout = layout
        
        
        
        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBAction func onClick_left(_ sender : UIButton){
    
        
        let index = currentIndex
        if index > 0 {
//            delegate?.itemScrolled(lastIndex: index, index: index-1)
            scroll(to: index - 1)
//            clv_stores.scrollToItem(at: IndexPath(item: index-1, section: 0), at: .centeredHorizontally, animated: true)
//            updateButtons(index: index - 1)
        }
        
        
        
        print("Index: \(index)")
    }
    @IBAction func onClick_right(_ sender : UIButton){
        let index = currentIndex
        if index != -1 && index < stores.count - 1 {
//            delegate?.itemScrolled(lastIndex: index, index: index+1)
            scroll(to: index + 1)
//            clv_stores.scrollToItem(at: IndexPath(item: index+1, section: 0), at: .centeredHorizontally, animated: true)
//            updateButtons(index: index + 1)
        }
    }
    func scroll(to index : Int){
        clv_stores.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
        
        updateButtons(index: index)
    }
//    func currentIndex() -> Int{
//        let indexs = clv_stores.indexPathsForVisibleItems
//        print("Indexs : \(indexs)")
//        if indexs.isEmpty {
//            return -1
//        }
//        return indexs[0].row
//    }
    
    
    
    func updateButtons(index : Int){
        
        if index == -1{
            nextGrey()
            previousGrey()
        }
        else{
            if index == 0 {
                previousGrey()
            }
            else{
                previousOrange()
                
            }
            if index == stores.count - 1{
                nextGrey()
            }
            else{
                nextOrange()
            }
            lastIndex = currentIndex
            currentIndex = index
            if currentIndex == lastIndex && isCurrentLocation{
                return
            }
            delegate?.itemScrolled(lastIndex: lastIndex, index: currentIndex)
        }
        
    }
    func nextOrange(){
        btn_right.isEnabled = true
        btn_right.setImage(UIImage(named: "arrow_next_yellow"), for: .normal)
    }
    func nextGrey(){
        btn_right.isEnabled = false
        btn_right.setImage(UIImage(named: "arrow_next_grey"), for: .normal)
    }
    func previousOrange(){
        btn_left.isEnabled = true
        btn_left.setImage(UIImage(named: "arrow_previous_yellow"), for: .normal)
    }
    func previousGrey(){
        btn_left.isEnabled = false
        btn_left.setImage(UIImage(named: "arrow_previous_grey"), for: .normal)
    }
    

}
extension HomeBottomView : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stores.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MapStoreCell.className, for: indexPath) as! MapStoreCell
        let store = stores[indexPath.row]
        cell.loadCell(object: store)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc : StoreDetailVC = StoreDetailVC.viewController()
        let store = stores[indexPath.row]
        vc.storeID = store._id ?? ""
        BaseNavVC.currentNav().pushViewController(vc, animated: true)
    }
    
    
}
extension HomeBottomView : UIScrollViewDelegate{
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
//        print("Image Preview DidEndScrollingAnimation")
        previewEndScrolling()
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        perform(#selector(scrollViewDidEndScrollingAnimation(_:)), with: nil, afterDelay: 0.3)
//        print("Image Preview ScrollViewDidScroll")
    }
    
    func previewEndScrolling() {
        let page = Int(clv_stores.contentOffset.x / clv_stores.frame.width)
        
        if page != currentIndex{
            delegate?.itemScrolled(lastIndex: lastIndex, index: page)
            updateButtons(index: page)
        }
        
        
        
        
    }
}
