//
//  BuyerOrderDetailVC.swift
//  HomeMade2
//
//  Created by Apple on 02/07/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
protocol BuyerOrderDetailVCDelegate : class {
    func itemUpdated(order : BuyerOrder?)
}

class BuyerOrderDetailVC: BaseVC {
    
    var orderID : String?
    var order : BuyerOrder?
    weak var delegate : BuyerOrderDetailVCDelegate?
    //MARK: OUTLETS FOR HEADER SECTION
    @IBOutlet weak var lbl_order: UILabel!
    @IBOutlet weak var lbl_date: UILabel!
    @IBOutlet weak var lbl_productQuantity: UILabel!
    @IBOutlet weak var lbl_status: UILabel!
    @IBOutlet weak var lbl_amount: UILabel!
    
    //MARK: FOR Localization.
    @IBOutlet weak var lbl_orderTitle: UILabel!
    @IBOutlet weak var lbl_dateTitle: UILabel!
    @IBOutlet weak var lbl_productQuantityTitle: UILabel!
    @IBOutlet weak var lbl_statusTitle: UILabel!
    @IBOutlet weak var lbl_amountTitle: UILabel!
    
    @IBOutlet weak var tbl_orderList: UITableView!
    
    

    static func viewController() -> BuyerOrderDetailVC{
        
        return UIStoryboard.profileStoryboard.instantiateViewController(withIdentifier: "BuyerOrderDetailVC") as! BuyerOrderDetailVC
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    override func setupView() {
        setBackBarButton()
        navigationItem.title = "ORDER DETAIL".localized
        tbl_orderList.register(BuyerOrderDetailItemCell.nib, forCellReuseIdentifier: BuyerOrderDetailItemCell.className)
        loadDataOnUI()
    }
    
    override func loadDataOnUI() {
        lbl_order.text = order?.orderNumber
        lbl_status.text = order?.statusString
        lbl_date.text = Date.showDate(from: order?.createdAt ?? "")
        lbl_productQuantity.text = "\(order?.orderDetails?.count ?? 1)"
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
    func fetchOrderDetail(){
        
        if orderID == nil {
            orderID = order?._id
        }
        
        
        OrderManager().buyerOrderDetail(id: orderID ?? "") { [weak self] (response, error) in
            if self?.checkResponse(response: response, error: error) ?? false{
                self?.order = response?.data
                self?.loadDataOnUI()
            }
        }
        
    
    }

}
extension BuyerOrderDetailVC: UITableViewDataSource, UITableViewDelegate, BuyerOrderDetailItemCellDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return order?.orderDetails?.count ?? 0;//productName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BuyerOrderDetailItemCell.className) as! BuyerOrderDetailItemCell
        if let orderDetail = order?.orderDetails?[indexPath.row]{
            cell.loadCell(object: orderDetail)
            cell.delegate = self
        }
        
        
        
        //        cell.lbl_ProductTitle.text = productName[indexPath.row]
        ////        cell.btn_ProductStatus.setTitle(productStatus[indexPath.row], for: .normal)
        //        cell.img_ProdctImg.image = productImage[indexPath.row]
        return cell
    }
    func onClick_status(object: OrderProductDetail) {
        let params = ["orderDetailId": object._id!] as [String : Any]
        OrderManager().completeProduct(params: params) { [weak self] (response, error) in
            if self?.checkResponse(response: response, error: error) ?? false{
                object.status = "completed"
                self?.tbl_orderList.reloadData()
                nvMessage.showSuccess(body: "Order is marked delivered successfully".localized, closure: {
                    self?.navigationItem.rightBarButtonItems = []
                    self?.delegate?.itemUpdated(order: self?.order)
                })
            }
        }
    }
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //
    //        return 130
    //    }
}
