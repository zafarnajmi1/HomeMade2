//
//  MyOrdersVC.swift
//  HomeMade2
//
//  Created by Afrah Tayyab on 6/27/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class MyOrdersVC: BaseVC {
    
    static func viewController() -> MyOrdersVC{
        
        return UIStoryboard.profileStoryboard.instantiateViewController(withIdentifier: "MyOrdersVC") as! MyOrdersVC
    }
    
    @IBOutlet weak var tbl_MyOrders: UITableView!
    
    var image : [UIImage] = [UIImage(named: "shopping-1165437__340")!,
                            UIImage(named: "shopping-1165437__340")!,
                            UIImage(named: "shopping-1165437__340")!,
                            UIImage(named: "shopping-1165437__340")!,
                            UIImage(named: "shopping-1165437__340")!,
                            UIImage(named: "shopping-1165437__340")!,
                            UIImage(named: "shopping-1165437__340")!,
                            UIImage(named: "shopping-1165437__340")!]
    
    var orderNUmber = ["12123" , "12123" , "132412", "6456", "12123" , "12123" , "132412",                      "6456"]
    
    var totlalProduct = ["1" , "3" , "12", "12", "4" , "5" , "6","45"]
    var totlalAmount = ["AED 10.0" , "AED 90.0" , "AED 99.0", "AED 19.0", "AED 18.0" , "AED 10.0" , "AED 71.0","AED 90.0"]
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.title = "MY ORDERS".localized
//        setBackBarButton()
        tbl_MyOrders.register(UINib(nibName: "ConfirmedOrderTblCell", bundle: nil), forCellReuseIdentifier: "ConfirmedOrderTblCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.title = "MY ORDERS".localized
        setBackBarButton()
    }

}

extension MyOrdersVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return orderNUmber.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tbl_MyOrders.dequeueReusableCell(withIdentifier: "ConfirmedOrderTblCell") as! ConfirmedOrderTblCell
        
        cell.img_OrderImg.image = image[indexPath.row]
        cell.lbl_orderNumber.text = orderNUmber[indexPath.row]
        cell.lbl_TotalProducts.text = totlalProduct[indexPath.row]
        cell.lbl_OrderAmount.text = totlalAmount[indexPath.row]
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = UserOrderdetailsVC.viewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}
