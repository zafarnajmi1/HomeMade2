//
//  StoreProductVC.swift
//  HomeMade2
//
//  Created by Apple on 08/07/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class StoreProductsVC: ProductListingVC {
    
    
    private static var storyboard: UIStoryboard{
        get {
            return UIStoryboard.home
        }
    }
    
//    static func vca<T>() -> T
//    {
//
//        return storyboard.instantiateViewController(withIdentifier: self.className) as! T
//
//    }
    
    var storeID : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //        setupView()
    }
    override func setupView() {
//        addNotificationButton()
//        addCartButton()
//        navigationItem.title = "FAVOURITE PRODUCTS".localized
        
        //        setBackBarButton()
        //        let cartbutton = cartButton()
        //        let filterButton = navBarButton(image: "filter", action: #selector(onClick_filter))
        
        //        navigationItem.rightBarButtonItems = [filterButton, cartbutton]
        
        //        navigationItem.title = "PRODUCT LISTING".localized
        
        clv_items.register(ProductListingCell.nib, forCellWithReuseIdentifier: ProductListingCell.className)
        clv_items.register(LoadMoreCollection.nib, forCellWithReuseIdentifier: LoadMoreCollection.className)
        
        params.store = storeID//[category?._id, subCat?._id] as? [String]
        
        
        fetchItems()
        
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
