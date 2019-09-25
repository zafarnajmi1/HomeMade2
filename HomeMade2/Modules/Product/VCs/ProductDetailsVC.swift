//
//  ProductDetailsVC.swift
//  HomeMade2
//
//  Created by Apple on 19/06/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

//class ProductDetailsVC: BaseVC {
//
//    var productDetails : ProductDetail?
//    var totalRows = 0
//    var totalQuantity: Int = 1
//    var productID : String = ""
//    var featureArray : [String] = []
//    var characteristics : [String] = []
//    var selectedCombination : Combination?
//
//    var shareButton : UIBarButtonItem {
//        get{
//            return navBarButton(image: "share_small", action: #selector(onClick_share))
//        }
//
//    }
//    var likedButton : UIBarButtonItem {
//        get{
//            return navBarButton(image: "heart_filled_nav", action: #selector(onClick_fav))
//        }
//    }
//    var unlikedButton : UIBarButtonItem {
//        get{
//            return navBarButton(image: "heart_empty_nav", action: #selector(onClick_fav))
//        }
//    }
//
//    @IBOutlet weak var tbl_details : UITableView!
//    @IBOutlet weak var btn_plus : UIButton!
//    @IBOutlet weak var btn_minus : UIButton!
//    @IBOutlet weak var btn_addToCart : UIButton!
//    @IBOutlet weak var lbl_quantity : UILabel!
//
//
//
//    static func viewController() -> ProductDetailsVC
//    {
//        return UIStoryboard.product.instantiateViewController(withIdentifier: "ProductDetailsVC") as! ProductDetailsVC
//
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupView()
//        // Do any additional setup after loading the view.
//    }
//    override func setupView() {
//        setBackBarButton()
////        tbl_details.tableFooterView = UIView(frame: .zero)
//
//        tbl_details.register(ProductDetailTopCell.nib, forCellReuseIdentifier: ProductDetailTopCell.className)
//        tbl_details.register(ProductDetailBottomCell.nib, forCellReuseIdentifier: ProductDetailBottomCell.className)
//        tbl_details.register(ProductDetailDropDownCell.nib, forCellReuseIdentifier: ProductDetailDropDownCell.className)
//        tbl_details.register(ProductDetailOptionsListCell.nib, forCellReuseIdentifier: ProductDetailOptionsListCell.className)
//        tbl_details.estimatedRowHeight = 100
////        updateLikeButton()
////        navigationItem.rightBarButtonItems = [shareButton, likedButton]
//
//        fetchProduct()
//        setupTexts()
//    }
//    func updateLikeButton(){
//        if productDetails?.isFavorite ?? false{
//            navigationItem.rightBarButtonItems = [shareButton, likedButton]
//        }
//        else{
//            navigationItem.rightBarButtonItems = [shareButton, unlikedButton]
//        }
//    }
//    override func setupTexts() {
//        navigationItem.title = "PRODUCT DETAIL"
//    }
//    func updateUI() {
//        totalRows = (productDetails?.priceables?.count ?? 0) + 2
//        tbl_details.reloadData()
//        if let priceAbles = productDetails?.priceables{
//            for obj in priceAbles{
//                featureArray.append(obj.feature?._id ?? "")
//            }
//        }
//        updateLikeButton()
//    }
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//    // MARK: - Network
//    func fetchProduct(){
//        startAnimating()
//        ProductManager().productDetail(productID: productID) { [weak self] (response, error) in
//            self?.stopAnimating()
//            if let error = error {
//                self?.alertMessage(message: error, completion: {
//
//                })
//            }
//            else{
//                if response?.success ?? false{
//                    self?.productDetails = response?.data
//                    self?.updateUI()
//                }
//                else{
//                    self?.alertMessage(message: response?.message ?? "Unknown Error".localized, completion: {
//
//                    })
//                }
//
//
//            }
//        }
//
//
//    }
//    // MARK: - IBActions
//    @IBAction func onClick_plus(_ sender : UIButton){
//        totalQuantity += 1
//        lbl_quantity.text = "\(totalQuantity)"
//    }
//    @IBAction func onClick_minus(_ sender : UIButton){
//        if totalQuantity > 0 {
//            totalQuantity -= 1
//            lbl_quantity.text = "\(totalQuantity)"
//        }
//
//    }
//    @objc func onClick_share(_ sender : UIButton){
////        if totalQuantity > 0 {
////            totalQuantity -= 1
////            lbl_quantity.text = "\(totalQuantity)"
////        }
//
//    }
//    @objc func onClick_fav(_ sender : UIButton){
//        if  AppSettings.loggedInUser()?.accountType == "seller"{
//            showError(body: "Supplier could not perform this action.".localized)
//            return
//        }
//
//        if let productID = productDetails?._id{
//            ProductManager().favoriteProduct(productID: productID) { [weak self] (response, error) in
//                if self?.checkResponse(response: response, error: error) ?? false {
//                    self?.productLikeChanged()
//
//                }
//            }
//        }
//
//
//
////        if totalQuantity > 0 {
////            totalQuantity -= 1
////            lbl_quantity.text = "\(totalQuantity)"
////        }
//
//    }
//    func productLikeChanged(){
//        var messages = ""
//        if productDetails?.isFavorite ?? false{
//            messages = "Product is dislked successfully".localized
//        }
//        else{
//            messages = "Product is liked successfully".localized
//        }
//        view.makeToast(messages)
////        showError(title: "Success!".localized, body: messages)
//        productDetails?.isFavorite = !(productDetails?.isFavorite ?? false)
//        updateLikeButton()
//    }
//    @IBAction func onClick_addToCart(_ sender : UIButton){
//        if totalQuantity < 1 {
//            return
//        }
//
//        var params = AddToCartParams()
//        params.product = productDetails?._id
//        params.quantity = totalQuantity
//        if productDetails?.hasCombination ?? false{
//            if let selectedCombination = selectedCombination{
////                var params = AddToCartParams()
//                params.combination = selectedCombination._id
//
//            }
//            else{
//                return
//            }
//        }
//        startAnimating()
//        ProductManager().addToCart(parameters: params) { [weak self] (response, error) in
//            if self?.checkResponse(response: response, error: error) ?? false{
//
//                nvMessage.showSuccess(body: response?.message ?? AppSettings.defaultSuccess, closure: {
//
//                })
//
////                nvMessage.showSuccess(title: "Add To Cart", body: response?.message ?? AppSettings.defaultSuccess)
//            }
//        }
//    }
//}
//extension ProductDetailsVC : UITableViewDelegate, UITableViewDataSource, ProductDetailOptionDelegate{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//       return totalRows
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row == 0 {
//            guard let cell = tbl_details.dequeueReusableCell(withIdentifier: ProductDetailTopCell.className) as? ProductDetailTopCell
//                else{
//                    return UITableViewCell()
//            }
//            if let productDetails = productDetails{
//                cell.loadCell(object: productDetails, combination: selectedCombination)
//            }
//
//            return cell
//
//        }
//        else if indexPath.row == totalRows - 1{
//            guard let cell = tbl_details.dequeueReusableCell(withIdentifier: ProductDetailBottomCell.className) as? ProductDetailBottomCell
//                else{
//                    return UITableViewCell()
//            }
//            if let productDetails = productDetails{
//                cell.loadCell(object: productDetails)
//            }
//            return cell
//        }
//        else{
//            guard let item = productDetails?.priceables?[indexPath.row-1] else {
//                return UITableViewCell()
//            }
//            if item.feature?.type == "dropdown"{
//                guard let cell = tbl_details.dequeueReusableCell(withIdentifier: ProductDetailDropDownCell.className) as? ProductDetailDropDownCell
//                    else{
//                        return UITableViewCell()
//                }
//
//                cell.loadCell(object: item, delegate: self, indexPath: indexPath)
//                return cell
//            }
//            else{
//                guard let cell = tbl_details.dequeueReusableCell(withIdentifier: ProductDetailOptionsListCell.className) as? ProductDetailOptionsListCell
//                    else{
//                        return UITableViewCell()
//                }
//                cell.loadCell(object: item, delegate: self, indexPath: indexPath)
//                return cell
//
//            }
//
//        }
////        return UITableViewCell()
//    }
//
//    func featureSelected(object: Feature, charactistic: Characteristic, indexPath: IndexPath) {
//        print("Delegate Called Implementation is called.")
////    }
//
////    func featureSelected(object : Features, charactistic : Characteristic, indexPath : IndexPath){
//        if !checkAllSelected() {
//            print("All features are not selected")
//            return
//        }
//        loadCharactristicArray()
//        if checkAndLoadCombination(){
//            if let cell = tbl_details.cellForRow(at: IndexPath.init(row: 0, section: 0)) as? ProductDetailTopCell
//            {
//                cell.loadCell(object: productDetails!, combination: selectedCombination)
//                //            cell.loadCell(object: productDetails, selectedCombination: selectedCombination)
//            }
//        }
//        else{
//            alertMessage(message: "Selected Combination does not have any product. Please select another combinatin.") {
//
//            }
//        }
//
//
//    }
//    func checkAllSelected() -> Bool {
//
//        let allSelected = true
//        if let priceAbles = productDetails?.priceables{
//            for obj in priceAbles{
//                if obj.selectedIndex == nil {
//                    return false
//                }
//            }
//        }
//        return allSelected
//    }
//    func loadCharactristicArray(){
//        characteristics = []
//        if let priceAbles = productDetails?.priceables{
//            for obj in priceAbles{
//                if let chrAry = obj.characteristics{
//                    let chr = chrAry[obj.selectedIndex!]
//                    characteristics.append(chr._id ?? "")
//                }
//            }
//        }
//    }
//    func checkAndLoadCombination() -> Bool{
//        if let combinations = productDetails?.combinations{
//            var combinationSelected = false
//            for comb in combinations{
//                if let chrArray = comb.characteristics {
//                    if chrArray.containsSameElements(as: characteristics){
//                        selectedCombination = comb
//                        combinationSelected = true
//                        break
//                    }
//                }
//            }
//            if combinationSelected == false {
//                selectedCombination = nil
//            }
//            else{
//            }
//            return combinationSelected
//        }
//        else{
//            return false
//        }
//    }
//
//
//}

