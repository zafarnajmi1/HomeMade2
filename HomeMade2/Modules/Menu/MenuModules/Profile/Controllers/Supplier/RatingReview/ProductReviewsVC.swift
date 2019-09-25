//
//  ProductReviewsVC.swift
//  TailerOnline
//
//  Created by apple on 3/13/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import UIKit

class ProductReviewsVC: UIViewController {

    //MARK:-  outlets
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
     var rootProduct = RootProductModel()
    
    //MARK:-  my life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //API Call
        requestToGetProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.title = "Rating & Reviews".localized
        setBackBarButton()
        
        //cell setup
        let id = "ProductCollectionViewCell"
        myCollectionView.registerCustomCell(withCellId: id )
        setCellLayout()
       
      
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        hideNavigationBarRightBtn()
    }
    
    
    //MARK:-  base configuration
    
    private func setCellLayout() {
        let width = (self.view.frame.size.width - 40) / 2
        let layout = self.myCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        layout.minimumLineSpacing = 15
        layout.itemSize = CGSize(width: width, height: 360)
    }
    
     //MARK:- web services
    func requestToGetProducts() {
        self.showNvLoader()
        let id = AppSettings.shared.loggedInUser?.data?.id ?? ""
        let params = ["store": id] as [String: Any]
        ProductManager.shared.fetchProducts(params: params) { (result) in
            self.hideNvloader()
            switch result {
            case .sucess(let rootModel):
                self.rootProduct = rootModel
                
                self.refreshCollectionView()
             
            case .failure(let error):
                self.myCollectionView.setEmptyView(message: error)
            }
        }
    }
    
    func refreshCollectionView() {
        let total = self.rootProduct.data?.count ?? 0
        if total == 0 {
            self.myCollectionView.setEmptyView()
        }
        else {
            self.myCollectionView.reloadData()
        }
    }
    
}


//MARK:-  collectionview implemenation
extension ProductReviewsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rootProduct.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        
        let model = rootProduct.data![indexPath.row]
        cell.setData(model: model)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let model = rootProduct.data![indexPath.row]
      let s = AppConstant.storyBoard.profile
      let vc = s.instantiateViewController(withIdentifier: "RatingReviewVC") as! RatingReviewVC
      vc.productId = model.id!
      self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
