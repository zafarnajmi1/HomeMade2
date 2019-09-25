//
//  ProductListingVC.swift
//  HomeMade2
//
//  Created by Apple on 14/06/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class ProductListingVC: BaseVC {
    
    @IBOutlet weak var clv_items : UICollectionView!
    
    var category : Category?
    var subCat : Subcategory?
    var params = SearchProductsRequest()
    
    var itemsList : [BaseProduct] = []
    
    

    
    static func viewController() -> ProductListingVC
    {
        return UIStoryboard.categoryStoryboard.instantiateViewController(withIdentifier: "ProductListingVC") as! ProductListingVC 
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let _ = params.isUpdated {
            params.isUpdated = nil
            fetchItems()
        }
    }
    override func setupView() {
        setBackBarButton()
        let cartbutton = cartButton()
        let filterButton = navBarButton(image: "filter", action: #selector(onClick_filter))
        
        navigationItem.rightBarButtonItems = [filterButton, cartbutton]
        
        navigationItem.title = "PRODUCT LISTING".localized
        
        clv_items.register(ProductListingCell.nib, forCellWithReuseIdentifier: ProductListingCell.className)
        clv_items.register(LoadMoreCollection.nib, forCellWithReuseIdentifier: LoadMoreCollection.className)
        clv_items.refreshControl = refreshControl
        params.categories = [category?._id, subCat?._id] as? [String]
        fetchItems()
        
        

        
    }

    override func pullToRefreshView() {
        fetchItems(skip: 0)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Network
    func fetchItems(skip : Int = 0)  {
        isRequestSent = true
        params.skip = skip
        if skip == 0 {
            startAnimating()
        }
        
        CategoryManager().searchItems(params : params) { [weak self] (response, error) in
            if skip == 0 {
                self?.stopAnimating()
            }
            self?.isRequestSent = false
            self?.refreshControl.endRefreshing()
            if let error = error {
                if skip == 0 {
                    self?.addEmptyView()
                }
                self?.alertMessage(message: error, completion: {})
            }
            else{
                if response?.success ?? false {
                    guard let itemsList = response?.data
                        else{
                            return
                    }
                    self?.isLoadMore = (itemsList.count > 0)
                    if skip == 0 {
                        self?.itemsList = itemsList
                    }
                    else{
                        self?.itemsList += itemsList
                    }
                    
                    
                    if self?.itemsList.isEmpty ?? false{
                            self?.addEmptyView()
                    }
                    else{
                        self?.removeEmptyView()
                    }
                    
                    self?.clv_items.reloadData()
                }
                else{
                    self?.alertMessage(message: response?.message ?? "", completion: {})
                }
            }
            
        }
    }
    
    // MARK: - Actions
    @objc func onClick_filter(){
        print("Moviing to Cart Screen")
        params.isUpdated = nil
        let vc = FilterVC.viewController()
        vc.listingFilter = params
        
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
        
    }

}
extension ProductListingVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == itemsList.count{
            let itemWidth = (AppSettings.screenWidth-40)
            let itemHeight : CGFloat = 40.0
            return CGSize(width: itemWidth, height: itemHeight)
        }
        else{

            let itemWidth = (AppSettings.screenWidth-30)/2
            let itemHeight = (itemWidth * (416.0/475.0)) + 165.0
            return CGSize(width: itemWidth, height: itemHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return itemsList.count// + (isLoadMore ? 1 : 0)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if isLoadMore && indexPath.row == itemsList.count - 1 && !isRequestSent{
            fetchItems(skip: itemsList.count)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductListingCell.className, for: indexPath) as? ProductListingCell
                else{
                    return UICollectionViewCell()
            }
            
            
            let object = itemsList[indexPath.row]
            cell.delegate = self
            cell.loadCell(object: object)
            
            return cell
//        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let object = itemsList[indexPath.row]
        
        let vc = ProductDetailsVC1.viewController()
        vc.productID = object._id ?? ""
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    func updateItemFav(productID : String){
        for (index, object) in self.itemsList.enumerated(){
            if object._id == productID{
                let cell = clv_items.cellForItem(at: IndexPath(item: index, section: 0)) as! ProductListingCell
                object.isFavorite = !(object.isFavorite ?? true)
                cell.loadCell(object: object)
            }
        }
    }
    
    
}
extension ProductListingVC : ProductListingCellDelegate{
    
    
    func onClick_like(product : BaseProduct){
        
        
        if  AppSettings.loggedInUser()?.accountType == "seller"{
             showError(body: "Supplier could not perform this action.".localized)
            return
        }

        if let productID = product._id{
            ProductManager().favoriteProduct(productID: productID) { [weak self] (response, error) in
                if self?.checkResponse(response: response, error: error) ?? false {
                    self?.updateItemFav(productID: productID)
                }
            }
        }
    }
    
}
