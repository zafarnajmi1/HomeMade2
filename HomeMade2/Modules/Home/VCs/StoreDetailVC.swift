//
//  StoreDetailVC.swift
//  HomeMade2
//
//  Created by Apple on 05/07/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class Review : Encodable {
    var comment : String = ""
    var rating : Double = 0
    var id : String = ""
//    var isRatting : Bool? = false
    
}
class StoreDetailVC: BaseVC {

    
    @IBOutlet weak var sc_segment: UISegmentedControl!
    @IBOutlet weak var cv_productList: UIView!
    @IBOutlet weak var tbl_info: UITableView!
    
    var review = Review()
    
//    var extraCells : Int = 2
    var rateUserCell : Int = -1
        
    var userInfoCell : Int {
        get {
            return 0
        }
    }
    var extraCells : Int {
        get {
            if rateUserCell == 1 {
                return 2
            }
            else{
                return 1
            }
        }
    }
    
    var storeDetail : StoreDetail?
    var storeReviews : [StoreReview] = []
    var storeID : String = ""
    static func viewController() -> StoreDetailVC
    {
        return UIStoryboard.home.instantiateViewController(withIdentifier: StoreDetailVC.className) as! StoreDetailVC
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        // Do any additional setup after loading the view.
    }
    override func setupView() {
        setBackBarButton()
        tbl_info.register(StoreDetailHeaderCell.nib, forCellReuseIdentifier: StoreDetailHeaderCell.className)
        tbl_info.register(RateSupplierCell.nib , forCellReuseIdentifier: RateSupplierCell.className)
        tbl_info.register(StoreReviewCell.nib, forCellReuseIdentifier: StoreReviewCell.className)
        review.id = storeID
        navigationItem.title = "SUPPLIER DETAIL".localized
        fetchStoreDetail()
//        cv_productList.em
    }

    override func loadDataOnUI() {
        
        tbl_info.reloadData()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "storeProducts" {
            if let vc = segue.destination as? StoreProductsVC{
                vc.storeID = storeID
            }
        }
        
    }
    
    @IBAction func onValueChange_segment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            tbl_info.isHidden = false
            cv_productList.isHidden = true
        }
        else{
            tbl_info.isHidden = true
            cv_productList.isHidden = false
        }
    }
    
    func fetchStoreDetail(){
        HomeManager().getStoreDetail(id: storeID) { [weak self] (response, error) in
            if self?.checkResponse(response: response, error: error) ?? false {
                self?.storeDetail = response?.data
                if let canReviews = self?.storeDetail?.canReviewUsers{
                    if canReviews.count > 0 {
                        self?.rateUserCell = 1
                    }
                }
                self?.loadDataOnUI()
                self?.fetchStoreReviews(skip: 0)
            }
        }
    }
    func fetchStoreReviews(skip: Int) {
        if skip == 0 {
            startAnimating()
        }
        isRequestSent = true
        HomeManager().getStoreReviews(skip : skip, id: storeID) { [weak self] (response, error) in
            if self?.checkResponse(response: response, error: error) ?? false {
                
                if skip == 0 {
                    self?.storeReviews = response?.data ?? []
                }
                else{
                    self?.storeReviews += response?.data ?? []
                }
                self?.isLoadMore = ((response?.data?.count ?? 0) > 0)
                self?.loadDataOnUI()
            }
        }
    }
    
}
extension StoreDetailVC : UITableViewDelegate, UITableViewDataSource, RateSupplierCellDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if storeDetail == nil{
            return 0
        }
        return extraCells + storeReviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == userInfoCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: StoreDetailHeaderCell.className) as! StoreDetailHeaderCell
            if let detail = storeDetail{
                cell.loadCell(object: detail)
            }
            return cell
        }
        else if indexPath.row == rateUserCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: RateSupplierCell.className) as! RateSupplierCell
            cell.delegate = self
            cell.loadCell(object: review)
            return cell
        }
        else {
            if isLoadMore && indexPath.row == storeReviews.count - (extraCells + 1) && !isRequestSent{
                fetchStoreReviews(skip: storeReviews.count)
            }
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: StoreReviewCell.className) as! StoreReviewCell
//            if let review =
            let review = storeReviews[indexPath.row - extraCells]
            cell.loadCell(object: review)
            return cell
        }
    }
    func onClick_send() {
        if review.rating == 0{
            showError(body: "Please provide ratting for this seller".localized)
        }
        else if review.comment == ""{
            showError(body: "Please write review for this seller".localized)
        }
        else{
            startAnimating()
            HomeManager().writeReviewForStore(review: review) { [weak self] (response, error) in
                if self?.checkResponse(response: response, error: error) ?? false {
                    self?.clearReviewCell()
//                    self?.fetchStoreDetail()
                    nvMessage.showSuccess(body: response?.message ?? "Review submitted sucessfully".localized, closure: {
                        self?.fetchStoreReviews(skip: 0)
                    })
//                    nvMessage.showSuccess(body: response?.message ?? "Review submitted sucessfully".localized)
                    
//                    self?.fetchStoreDetail()
                    
                }
            }
        }
    }
    func clearReviewCell(){
        
//        let user = AppSettings.loggedInUser()
//        let ru = ReviewUser(_id: user?._id, image: user?.image, firstName: user?.firstName, lastName: user?.lastName)
//        let store = ReviewStore(_id: storeDetail?._id, storeName: storeDetail?.storeName, averageRating: storeDetail?.averageRating, storeNameEn: storeDetail?.storeNameEn, storeNameAr: storeDetail?.storeNameAr)
//        let storeReview = StoreReview(_id: "", rating: review.rating, comment: review.comment, user: ru, store: store, createdAt: Date.makeServerDate(from: Date()))
//        storeReviews.insert(storeReview, at: 0)
        
        review.rating = 0.0
        review.comment = ""
//        rateUserCell = -1
//        tbl_info.reloadData()
        if let cell = tableView(tbl_info, cellForRowAt: IndexPath(row: 1, section: 0)) as? RateSupplierCell{
            cell.loadCell(object: review)
        }
    }
    
}
