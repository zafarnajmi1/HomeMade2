//
//  RatingReviewVC.swift
//  TailerOnline
//
//  Created by apple on 3/12/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import UIKit
import Cosmos
class RatingReviewVC: UIViewController {

     //MARK:-  outlest
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var avrageStars: CosmosView!
    @IBOutlet weak var ratingNumber: UILabel!
    @IBOutlet weak var totalReviews: UILabel!
    @IBOutlet weak var productReviewsLabel: UILabel!
    
     //MARK:- properties
    var productId:String!
    var rootModel = RootProductDetailModel()
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let rating = AppSettings.shared.loggedInUser?.averageRating ?? 0
        self.ratingNumber.text = "\(rating)"
        self.avrageStars.rating = rating
        let reviewLabel = "Reviews".localized
        self.totalReviews.text = "0 \(reviewLabel)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Rating & Reviews".localized
        setBackBarButton()
        setLocalization()
        //register cell
        let id = "RatingReviewTableViewCell"
        tableView.registerCustomCell(withCellId: id)
        //apply theme
//        headerView.backgroundColor = myDefaultTheme.primaryColor
        //api call
        requestToGetProductReviews()
    }

    func setLocalization() {
        productReviewsLabel.text = "Product Reviews".localized
    }
    
    
    //MARK:- web services
    func requestToGetProductReviews() {
        self.showNvLoader()
        
        ProductManager.shared.productDetailBy(id: productId) { (result) in
            self.hideNvloader()
            switch result {
            case .sucess(let root):
                self.rootModel = root
                
                self.refreshTableView()
              
            case .failure(let error):
                self.tableView.setEmptyView(message: error)
            }
        }
    }
    
    func refreshTableView() {
        
        let reviewLabel = "Reviews".localized
        let total = self.rootModel.data?.reviews?.count ?? 0
        self.totalReviews.text = "\(total) \(reviewLabel)"
        let rating = self.rootModel.data?.averageRating ?? 0
        self.ratingNumber.text = "\(rating)"
        self.avrageStars.rating = rating
        
        if total == 0 {
            self.tableView.setEmptyView()
        }
        else {
            self.tableView.reloadData()
        }
    }

}

extension RatingReviewVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
         return rootModel.data?.reviews?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RatingReviewTableViewCell") as! RatingReviewTableViewCell
        let model = (rootModel.data?.reviews?[indexPath.row])!
        cell.setData(model: model)
        return cell
    }
    
    
}
