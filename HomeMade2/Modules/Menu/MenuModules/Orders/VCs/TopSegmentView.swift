//
//  TopSegmentView.swift
//  HomeMade2
//
//  Created by Apple on 12/07/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit


class SegmentObject {
    var title : String
    var isSelected : Bool
    var itemCount : Int?
    init(title : String, isSelected : Bool, itemCount : Int?) {
        self.itemCount = itemCount
        self.title = title
        self.isSelected = isSelected 
    }
    
}
protocol TopSegmentViewDelegate : class {
    func segmentChanged(index: Int)
}
class TopSegmentView: UIView {
    
    var selectedIndex : Int = 0
    weak var delegate : TopSegmentViewDelegate?
    
    @IBOutlet weak var clv_options : UICollectionView!
    var itemHeight : CGFloat = 50
    
    
    var itemsList = [
        SegmentObject(title: "Confirmed".localized, isSelected: true, itemCount: nil),
        SegmentObject(title: "Shipped".localized, isSelected: false, itemCount: nil),
        SegmentObject(title: "Completed".localized, isSelected: false, itemCount: nil),
        SegmentObject(title: "Cancelled".localized, isSelected: false, itemCount: nil)
    ]

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {

        clv_options.register(SegmentCell.nib, forCellWithReuseIdentifier: SegmentCell.className)
        clv_options.delegate = self
        clv_options.dataSource = self
        setupCollectionLayout()
    }
    func setupCollectionLayout(){
        let itemWidth: CGFloat  = ((AppSettings.screenWidth - 40)/3)
        let layout = clv_options.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        clv_options.collectionViewLayout = layout
    }
    func updateCount(orderStatus : OrderStatus){
        for (index,object) in itemsList.enumerated(){
            
            switch index {
            case 0:
                object.itemCount = orderStatus.confirmed
            case 1:
                object.itemCount = orderStatus.shipped
            case 2:
                object.itemCount = orderStatus.completed
            case 3:
                object.itemCount = orderStatus.cancelled
            default:
                print("No statment execudted")
            }
        }
        clv_options.reloadData()
    }

}
extension TopSegmentView : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SegmentCell.className, for: indexPath) as! SegmentCell
        let object = itemsList[indexPath.row]
        cell.loadCell(object: object)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row != selectedIndex {
            
            let item = itemsList[selectedIndex]
            item.isSelected = false
            cellforItem(at: selectedIndex).loadCell(object: item)
            selectedIndex = indexPath.row
            let selectedItem = itemsList[selectedIndex]
            selectedItem.isSelected = true
            cellforItem(at: selectedIndex).loadCell(object: selectedItem)
            delegate?.segmentChanged(index: selectedIndex)
        }
    }
    func cellforItem (at index : Int) -> SegmentCell{
        let cell = clv_options.cellForItem(at: IndexPath(item: index, section: 0)) as! SegmentCell
        return cell
    }
    
    
}
