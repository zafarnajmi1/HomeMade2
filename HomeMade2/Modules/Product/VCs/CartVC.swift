//
//  CartVC.swift
//  HomeMade2
//
//  Created by Apple on 10/06/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class CartVC: BaseVC {

    @IBOutlet weak var lbl_totalTitle : UILabel!
    @IBOutlet weak var lbl_total : UILabel!
    @IBOutlet weak var btn_continueToCheckout : UIButton!
    var cart : CartObject?
    var cartList : [CartItem] {
        get {
            if let cart = cart {
                return cart.cartItems ?? []
            }
            return []
        }
    }
    @IBOutlet weak var tbl_cartList : UITableView!
    static func viewController() -> CartVC{
        
        return UIStoryboard.product.instantiateViewController(withIdentifier: "CartVC") as! CartVC
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    override func setupView() {
        tbl_cartList.register(CartCell.nib, forCellReuseIdentifier: CartCell.className)
        refreshControl.addTarget(self, action: #selector(reloadCartList), for: .valueChanged)
        tbl_cartList.refreshControl = refreshControl
        tbl_cartList.tableFooterView = UIView(frame: .zero)
        setupTexts()
        setBackBarButton()
        fetchCartList()
    }
    override func setupTexts() {
        navigationItem.title = "CART".localized
        btn_continueToCheckout.setTitle("CONTINUE TO CHECKOUT".localized, for: .normal)
        lbl_totalTitle.text = "Total Bill".localized
    }
    func updateUI(){
        lbl_total.text = cart?.grandTotal?.showPrice?.formattedText
//        tbl_cartList.beginUpdates()
        tbl_cartList.reloadData()
        refreshControl.endRefreshing()
//        tbl_cartList.endUpdates()
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
    func fetchCartList(showLoader : Bool = true) {
        if showLoader{
            startAnimating()
        }
        ProductManager().getMyCart { [weak self] (response, error) in
            if showLoader{
                self?.stopAnimating()
            }
            if let error = error {
                self?.alertMessage(message: error, completion: {
                    
                })
            }
            else{
                if response?.success ?? false{
                    self?.cart = response?.data
                    self?.updateUI()
                }
                else{
                    self?.alertMessage(message: response?.message ?? "Unknown Error".localized, completion: {
                        
                    })
                }
                
                
            }
        }
    }
    // MARK: - IBActions
    
    @objc func reloadCartList(){
        fetchCartList(showLoader: false)
    }
    @IBAction func onClick_continue(_ sender : UIButton){
        let vc = BillShipAddressVC.viewController()
        vc.cartList = cartList
        vc.billAmount = cart?.grandTotal
        navigationController?.pushViewController(vc, animated: true)
    }

}
extension CartVC : UITableViewDelegate, UITableViewDataSource, CartCellDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartCell.className) as? CartCell
            else{
                return UITableViewCell()
        }
        let item = cartList[indexPath.row]
        cell.loadCell(object: item, delegate: self)
        return cell
    }
    func deleteItem(object : CartItem?){
        guard let object = object else{
            return
        }
        
        if let productID = object.product?._id{
            startAnimating()
            ProductManager().removeFromCart(itemID: productID) { [weak self] (response, error) in
                self?.stopAnimating()
                if let error = error {
                    self?.alertMessage(message: error, completion: {
                        
                    })
                }
                else{
                    if response?.success ?? false{
                        self?.fetchCartList()
                    }
                    else{
                        self?.alertMessage(message: response?.message ?? "Unknown Error".localized, completion: {
                            
                        })
                    }
                    
                    
                }
            }
        }
        
    }
    func selectItem(object: CartItem?) {
        guard let object = object, let productID = object.product?._id else{
            return
        }
        let productVC = ProductDetailsVC1.viewController()
        productVC.productID = productID
        self.navigationController?.pushViewController(productVC, animated: true)
        

    }
    func updateItem(object : CartItem?, quantity : Int){
        guard let object = object else{
            return
        }
        if let productID = object.product?._id{
            var productParams = AddToCartParams()
            productParams.quantity = quantity
            productParams.product = productID
            if object.product?.hasCombination ?? false, let combination = object.combination{
                
//                for cartCombination in object.product?.combinations ?? []{
//                    if cartcom
//                }
//                if let combination = object.combinationDetail?.first{
                    productParams.combination = combination
                
//                for obj in object.product?.hasCombination{
//                    
//                }
//                }
            }

            startAnimating()
            ProductManager().updateCart(parameters: productParams) { [weak self] (response, error) in
                self?.stopAnimating()
                if let error = error {
                    self?.alertMessage(message: error, completion: {
                    })
                }
                else{
                    if response?.success ?? false{
                        self?.fetchCartList()
                    }
                    else{
                        self?.alertMessage(message: response?.message ?? "Unknown Error".localized, completion: {
                            
                        })
                    }
                }
            }
        }
    }
    
}
