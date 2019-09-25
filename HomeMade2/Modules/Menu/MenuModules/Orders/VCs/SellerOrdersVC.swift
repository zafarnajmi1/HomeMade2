//
//  MyOrdersVC.swift
//  HomeMade2
//
//  Created by Afrah Tayyab on 6/27/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit


class SellerOrdersVC: BaseVC {
    
    @IBOutlet weak var tbl_myOrders: UITableView!
//    @IBOutlet weak var usc_segment : UISegmentedControl!
    @IBOutlet weak var uv_topSegment : TopSegmentView!
    var orderID : String?
    var orders : [SellerOrder] = []
    
    var orderType : OrderType = .Confirmed
    var isFromCheckout : Bool = false

    
    
    
    

    static func viewController() -> SellerOrdersVC{
        
        return UIStoryboard.profileStoryboard.instantiateViewController(withIdentifier: "SellerOrdersVC") as! SellerOrdersVC
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
//        self.title = "MY ORDERS".localized
//        setBackBarButton()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if orderID != nil{
//            for (index, object) in orders.enumerated(){
                fetchOrders(index: uv_topSegment.selectedIndex)
//            }
            self.orderID = nil
            tbl_myOrders.reloadData()
        }
    }
    
    override func setupView() {
        
//        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
//        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
//        segmentedControl.setTitleTextAttributes(titleTextAttributes, for: .normal)
//        usc_segment.setTitleTextAttributes(titleTextAttributes, for: .normal)
        
        tbl_myOrders.register(SellerOrderCell.nib, forCellReuseIdentifier: SellerOrderCell.className)
        tbl_myOrders.tableFooterView = UIView(frame: .zero)
        tbl_myOrders.refreshControl = refreshControl
        navigationItem.title = "MY ORDERS".localized
        setBackBarButton()
        fetchOrders()
        uv_topSegment.delegate = self
    }
    override func pullToRefreshView() {
        fetchOrders(index: uv_topSegment.selectedIndex)
    }
    override func backToMain() {
        if isFromCheckout{
            self.navigationController?.tabBarController?.selectedIndex = 0
            self.navigationController?.popToRootViewController(animated: false)
        }
        else{
            super.backToMain()
        }
    }
    func fetchOrders(index : Int = 0){
        var status = ""
//        let index = usc_segment.selectedSegmentIndex
        if index == 0 {
            status = "confirmed"
        }
        else if index == 1 {
            status = "shipped"
        }
        else if index == 2{
            status = "completed"
        }
        else if index == 3{
            status = "cancelled"
        }
        let params = ["status" : status]
        startAnimating()
        OrderManager().fetchSellerOrders(params: params) { [weak self] (response, error) in
            if self?.checkResponse(response: response, error: error) ?? false {
                self?.orders = response?.data ?? []
                self?.tbl_myOrders.reloadData()
                self?.fetchOrdersStatusCount()
                if self?.orders.isEmpty ?? false{
                    self?.addEmptyView()
                }
                else{
                    self?.removeEmptyView()
                }
            }
        }
    }
    func fetchOrdersStatusCount(){
        OrderManager().fetchOrderStatus() { [weak self] (response, error) in
            if self?.checkResponse(response: response, error: error) ?? false{
                if let orderStatus = response?.data{
                    self?.uv_topSegment.updateCount(orderStatus: orderStatus)
                }
                
            }
        }
    }
    @IBAction func onClick_segmentedBar(_ sender: UISegmentedControl) {
        
        fetchOrders()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//
//
////        setBackBarButton()
//    }

}
extension SellerOrdersVC : TopSegmentViewDelegate{
    func segmentChanged(index: Int) {
        fetchOrders(index: index)
    }
    
    
}
extension SellerOrdersVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SellerOrderCell.className) as! SellerOrderCell
        let orderItem = orders[indexPath.row]
        cell.loadCell(object: orderItem)
        cell.delegate = self
//        cell.img_OrderImg.image = image[indexPath.row]
//        cell.lbl_orderNumber.text = orderNUmber[indexPath.row]
//        cell.lbl_TotalProducts.text = totlalProduct[indexPath.row]
//        cell.lbl_OrderAmount.text = totlalAmount[indexPath.row]
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
    }
    
    
}
extension SellerOrdersVC : SellerOrderDetailVCDelegate{
    func itemUpdated(order: SellerOrder?) {
        orderID = order?._id
    }
    
    
}
