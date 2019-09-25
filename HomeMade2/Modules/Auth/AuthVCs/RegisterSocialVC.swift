//
//  RegisterSocialVC.swift
//  TailerOnline
//
//  Created by apple on 3/4/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import UIKit

class RegisterSocialVC: BaseRegisterVC {

    //MARK:- outlets
    
//    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btn_registerUser: UIButton!
    @IBOutlet weak var btn_registerSuplier: UIButton!
    @IBOutlet weak var tbl_register: UITableView!
    var isBuyer = true
//    @IBOutlet weak var mySegmentControl: UISegmentedControl!
    
    
     //MARK:- properties
    var profileModel: SocialUser?
    
    //MARK:-  my life cycle
    static func viewController() -> RegisterSocialVC{
        
        return UIStoryboard.authStoryboard.instantiateViewController(withIdentifier: "RegisterSocialVC") as! RegisterSocialVC
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "REGISTER".localized
        setBackBarButton()
        setMylocalization()
//        mySegmentControl.setCustomAppearance()
    }
    
    
    
    //MARK:- actions
    
//    @IBAction func mySegmentTapped(_ sender: UISegmentedControl) {
//
//        tableView.reloadData()
//
//    }
    
    
    
    //MARK:-  base configurations
    func setMylocalization() {
//        mySegmentControl.setTitle("Customers".localized, forSegmentAt: 0)
//        mySegmentControl.setTitle("Suppliers".localized, forSegmentAt: 1)
    }
    @IBAction func onClick_registerUser(_ sender: Any) {
        isBuyer = true
        btn_registerUser.backgroundColor = #colorLiteral(red: 0.9710801244, green: 0.6898229718, blue: 0.2214611471, alpha: 1)
        btn_registerUser.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        btn_registerSuplier.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        btn_registerSuplier.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        tbl_register.reloadData()
        
        //        uv_genderView.isHidden = false
        //        lc_genderView.priority = UILayoutPriority(rawValue: 250)
        
    }
    @IBAction func onClick_registerSuplier(_ sender: Any) {
        isBuyer = false
        btn_registerUser.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        btn_registerUser.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        btn_registerSuplier.backgroundColor = #colorLiteral(red: 0.9710801244, green: 0.6898229718, blue: 0.2214611471, alpha: 1)
        btn_registerSuplier.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        tbl_register.reloadData()
        
    }
   
    
}

extension RegisterSocialVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isBuyer {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SocialRegisterBuyerCell") as! SocialRegisterBuyerCell
            cell.sharedVC = self
            cell.setData(model: profileModel!)
//            cell.profileModel = profileModel
            return cell
        }
       
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SocialRegisterSellerCell") as! SocialRegisterSellerCell
            cell.sharedVC = self
            cell.setData(model: profileModel!)
//            cell.profileModel = profileModel
            return cell
        }
   
    }
    
    
}
