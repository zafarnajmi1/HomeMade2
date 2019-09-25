//
//  FavouriteVC.swift
//  HomeMade2
//
//  Created by Apple on 12/06/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class FavouriteVC: ProductListingVC {

   
    static func vc() -> FavouriteVC
    {
        return UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "FavouriteVC") as! FavouriteVC
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
//        setupView()
    }
    override func setupView() {
        addNotificationButton()
        addCartButton()
        navigationItem.title = "FAVOURITE PRODUCTS".localized
        
//        setBackBarButton()
//        let cartbutton = cartButton()
//        let filterButton = navBarButton(image: "filter", action: #selector(onClick_filter))
        
//        navigationItem.rightBarButtonItems = [filterButton, cartbutton]
        
//        navigationItem.title = "PRODUCT LISTING".localized
        
        clv_items.register(ProductListingCell.nib, forCellWithReuseIdentifier: ProductListingCell.className)
        clv_items.register(LoadMoreCollection.nib, forCellWithReuseIdentifier: LoadMoreCollection.className)
        
        params.isFavorite = true//[category?._id, subCat?._id] as? [String]
//        refreshControl.addTarget(self, action: #selector(abc), for: .valueChanged)
//        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        clv_items.refreshControl = refreshControl
//        refreshControl.beginRefreshing()
        
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
