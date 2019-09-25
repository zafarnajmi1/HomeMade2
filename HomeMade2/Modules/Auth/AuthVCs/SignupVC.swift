//
//  SignupVC.swift
//  HomeMade2
//
//  Created by Apple on 14/05/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class SignupVC: BaseRegisterVC {

//    @IBOutlet weak var txt_firstName: UITextField!
//    @IBOutlet weak var txt_lastName: UITextField!
//    @IBOutlet weak var txt_email: UITextField!
//    @IBOutlet weak var txt_phoneNumber: UITextField!
//    @IBOutlet weak var txt_password: UITextField!
//    @IBOutlet weak var txt_confirmPassowrd: UITextField!
//    @IBOutlet weak var txt_address: UITextField!
    
    
    @IBOutlet weak var btn_registerUser: UIButton!
    @IBOutlet weak var btn_registerSuplier: UIButton!
    @IBOutlet weak var tbl_register: UITableView!
    
//    @IBOutlet weak var lbl_firstName: UILabel!
//    @IBOutlet weak var lbl_lastName: UILabel!
//    @IBOutlet weak var lbl_email: UILabel!
//    @IBOutlet weak var lbl_password: UILabel!
//    @IBOutlet weak var lbl_confirmPassowrd: UILabel!
//    @IBOutlet weak var lbl_address: UILabel!
//    @IBOutlet weak var lbl_phone: UILabel!
//    @IBOutlet weak var lbl_selectGender: UILabel!
//    @IBOutlet weak var btn_male: UIButton!
//    @IBOutlet weak var btn_female: UIButton!
//
//    @IBOutlet weak var lc_genderView: NSLayoutConstraint!
//    @IBOutlet weak var uv_genderView: UIView!
    
    var rootScreen: AuthRootScreen?
    var isBuyer = true
    
    
    static func viewController() -> SignupVC{
        
        return UIStoryboard.authStoryboard.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        // Do any additional setup after loading the view.
    }
    override func setupView() {
        setBackBarButton()
        navigationItem.title = "REGISTER"
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
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
//    @IBAction func onClick_signup(_ sender: Any) {
//    }
//    @IBAction func onClick_male(_ sender: Any) {
//
//
//
//        btn_male.setImage(#imageLiteral(resourceName: "radiobutton_sl"), for: .normal)
//        btn_female.setImage(#imageLiteral(resourceName: "radiobutton_unsl"), for: .normal)
//
//
//    }
//    @IBAction func onClick_female(_ sender: Any) {
//        btn_male.setImage(#imageLiteral(resourceName: "radiobutton_unsl"), for: .normal)
//        btn_female.setImage(#imageLiteral(resourceName: "radiobutton_sl"), for: .normal)
//
//    }
    @IBAction func onClick_login(_ sender: Any) {
        if self.rootScreen == .login {
            navigationController?.popViewController(animated: true)
        }
        else{
            let vc = LoginVC.viewController()
            vc.rootScreen = .register
            navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    
    
}
extension SignupVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isBuyer {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RegisterBuyerCell") as! RegisterBuyerCell
            cell.sharedVC = self
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "RegisterSellerCell") as! RegisterSellerCell
            cell.sharedVC = self
            return cell
        }
    }
    
    
}
