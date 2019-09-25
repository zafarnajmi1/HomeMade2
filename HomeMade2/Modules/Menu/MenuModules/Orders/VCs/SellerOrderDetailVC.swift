//
//  SellerOrderDetailVC.swift
//  HomeMade2
//
//  Created by Apple on 02/07/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit


protocol SellerOrderDetailVCDelegate : class {
    func itemUpdated(order : SellerOrder?)
}

class SellerOrderDetailVC: BaseVC {

    weak var order : SellerOrder?
    weak var delegate : SellerOrderDetailVCDelegate?
    @IBOutlet weak var tbl_orderList: UITableView!
    
    static func viewController() -> SellerOrderDetailVC{
        
        return UIStoryboard.profileStoryboard.instantiateViewController(withIdentifier: "SellerOrderDetailVC") as! SellerOrderDetailVC
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        // Do any additional setup after loading the view.
    }
    override func setupView() {
        setBackBarButton()
        navigationItem.title = "ORDER DETAIL".localized
        tbl_orderList.register(SellerOrderHeaderCell.nib, forCellReuseIdentifier: SellerOrderHeaderCell.className)
        tbl_orderList.register(SellerOrderDetailItemCell.nib, forCellReuseIdentifier: SellerOrderDetailItemCell.className)
        tbl_orderList.tableFooterView = UIView(frame: .zero)
        
        if order?.status == "confirmed"{
            addRightButton(title: "Cancel Order".localized, action: #selector(onClick_cancelOrder))
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func onClick_cancelOrder() {
        guard let object = order
        else{
            return
        }
        let params = ["orderDetailId": object._id!] as [String : Any]
        startAnimating()
        OrderManager().cancelProduct(params: params) { [weak self] (response, error) in
            if self?.checkResponse(response: response, error: error) ?? false{
                object.status = "cancelled"
                let cell = self?.tbl_orderList.cellForRow(at: IndexPath(row: 1, section: 0)) as! SellerOrderDetailItemCell
                cell.loadCell(object: object)
                nvMessage.showSuccess(body: "Order is cancelled successfully".localized, closure: {
                    self?.navigationItem.rightBarButtonItems = []
                    self?.delegate?.itemUpdated(order: object)
                })
            }
        }
    }
    

}
extension SellerOrderDetailVC: UITableViewDataSource, UITableViewDelegate, SellerOrderDetailItemCellDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;//productName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: SellerOrderHeaderCell.className) as! SellerOrderHeaderCell
            if let order = order{
                cell.loadCell(object: order)
            }
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: SellerOrderDetailItemCell.className) as! SellerOrderDetailItemCell
            if let order = order{
                cell.loadCell(object: order)
                cell.delegate = self
            }
            return cell
        }

    }
    func onClick_status(object: SellerOrder) {
        startAnimating()
        let params = ["orderDetailId": object._id!] as [String : Any]
        OrderManager().shipProduct(params: params) { [weak self] (response, error) in
            if self?.checkResponse(response: response, error: error) ?? false{
                object.status = "shipped"
                let cell = self?.tbl_orderList.cellForRow(at: IndexPath(row: 1, section: 0)) as! SellerOrderDetailItemCell
                cell.loadCell(object: object)
                nvMessage.showSuccess(body: "Order is shipped successfully".localized, closure: {
                    self?.navigationItem.rightBarButtonItems = []
                    self?.delegate?.itemUpdated(order: object)
                })
            }
        }
    }
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //
    //        return 130
    //    }
}
