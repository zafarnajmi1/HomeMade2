//
//  RatingReviewVC.swift
//  TailerOnline
//
//  Created by apple on 3/12/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import UIKit
import Cosmos
class RatingReviewVC: BaseVC {

  
    //MARK:- outlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var stars: CosmosView!
    @IBOutlet weak var ratingNumber: UILabel!
    @IBOutlet weak var totalReviews: UILabel!
    
    //MARK:- variables
    var reviewsList : [StoreReview] = []
    private var reviewPagination: Pagination?
    
    static func viewController() -> RatingReviewVC{
        
        return UIStoryboard.menuStoryboard.instantiateViewController(withIdentifier: "RatingReviewVC") as! RatingReviewVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //register
        self.title = "Rating & Reviews"
        setupView()
    }
    
    
    override func setupView()  {
        tableView.register(RatingReviewCell.nib, forCellReuseIdentifier: RatingReviewCell.className)
        
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        tableView.estimatedRowHeight = 200
        setBackBarButton()
        fetchReviews()

    }

    func loadDataOnUI(response : RattingReviewsResponse?) {
        if let count = response?.reviewsCount{
            if count == 1 {
                totalReviews.text = "(\(count) Review)".localized
            }
            else{
                totalReviews.text = "(\(count) Reviews)".localized
            }
            
        }
        else{
            totalReviews.text = "(No Review)".localized
        }
        if reviewsList.count > 0 {
            let obj = reviewsList[0]
            stars.rating = obj.store?.averageRating ?? 0.0
            ratingNumber.text = "\(obj.store?.averageRating ?? 0.0)"
        }
        else{
            stars.rating =  0.0
            ratingNumber.text = "0.0"
        }
        
        
        
        
    }
    
}

//MARK:-  setup API with Pagination
extension RatingReviewVC {
    
    
    
    func fetchReviews(skip : Int = 0){
        
//        guard let storeID = AppSettings.loggedInUser()?._id else {
//            nvMessage.showError(body: "Store Id Not Found".localized)
//            return
//        }
        
//        let perPage = 50
//        let nextPage = reviewPagination?.next ?? 1
        
//        let params = ["skip": skip] as [String: Any]
        
        ProfileManager().getMyStoreReviews(skip: skip) { [weak self] (response, error) in
            if self?.checkResponse(response: response, error: error) ?? false {
                if skip == 0 {
                    self?.reviewsList = response?.data?.reviewsList ?? []
                }
                else{
                    self?.reviewsList += response?.data?.reviewsList ?? []
                }
                self?.isLoadMore = ((response?.data?.reviewsList?.count ?? 0) != 0)
                self?.tableView.reloadData()
                self?.loadDataOnUI(response: response?.data)
            }
        }
//        StoreManager.shared.storeReviews(params: params ) { (result) in
//
//            self.hideNvloader()
//            ProgressHUD.dismiss(animated: true)
//
//            switch result {
//
//            case .sucess(let root):
//                self.updateReviewList(response: root.data)
//
//            case .failure(let error):
//                nvMessage.showError(body: error)
//
//            }
//
//        }
    }
    
//    func updateReviewList(response: ReviewCollection? )  {
//
//        self.reviewPagination = response?.pagination
//
//        if reviewPagination?.page ?? 0 == 1 {
//            self.reviews = response?.reviews ?? []
//            self.tableView.reloadData()
//        }
//        else {
//            self.reviews?.append(contentsOf: response?.reviews ?? [])
//            self.tableView.reloadData()
//        }
//
//        let postfix = "total Reivews".localized
//        self.totalReviews.text = "(\(reviews?.count ?? 0) \(postfix))"
//    }
    
    
    
}

extension RatingReviewVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
            return reviewsList.count
       
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == (reviewsList.count - 1) && isLoadMore {
            fetchReviews(skip: reviewsList.count)
        }
            let cell = tableView.dequeueReusableCell(withIdentifier: RatingReviewCell.className) as! RatingReviewCell
            let model = reviewsList[indexPath.row]
        cell.loadCell(object: model)
//            cell.setData(model: model!)
            return cell
        
    }
    
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        
//        if (tableView.contentOffset.y + tableView.frame.size.height) >= tableView.contentSize.height - 10 {
//            let canFetch = MyPagination.shared.checkFetchMore(model: reviewPagination)
//            if canFetch {
//                ProgressHUD.present(animated: true)
//                self.requestToFetchStoreReviews()
//            }
//            
//        }
//    }
    
}
