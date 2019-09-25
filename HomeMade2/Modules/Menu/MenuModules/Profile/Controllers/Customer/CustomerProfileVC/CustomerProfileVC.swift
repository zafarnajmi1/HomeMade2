//
//  CustomerProfileVC.swift
//  TailerOnline
//
//  Created by apple on 3/5/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import UIKit
//import Closures

class CustomerProfileVC: BaseVC {

     //MARK:- outlets
    @IBOutlet weak var img_image: UIImageView!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var lbl_email: UILabel!
    @IBOutlet weak var lbl_phone: UILabel!
    @IBOutlet weak var lbl_gender: UILabel!
    @IBOutlet weak var lbl_address: UILabel!
    
    //labels localization
    @IBOutlet weak var lbl_phoneTitle: UILabel!
    @IBOutlet weak var lbl_genderTitle: UILabel!
    @IBOutlet weak var lbl_addressTitle: UILabel!
    @IBOutlet weak var btn_editProfile: UIButton!
    
    
//    var profileModel = LoginResponse()
    var user : User?
    
    static func viewController() -> CustomerProfileVC{
        
        return UIStoryboard.profileStoryboard.instantiateViewController(withIdentifier: "CustomerProfileVC") as! CustomerProfileVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        
    }
    
    override func setupView() {
        setBackBarButton()
        
    }
    override func loadDataOnUI() {
        //if let user = User1{
        guard let user = user else {
            return
        }
            lbl_name.text = "\(user.firstName ?? "") \(user.lastName ?? "")"
            lbl_email.text = user.email
            lbl_phone.text = user.phone
            lbl_gender.text = user.gender
            lbl_address.text = user.address
            img_image.kf.setImage(with: URL(string: user.image ?? ""), placeholder: UIImage(named: "placeholder_user"))
            
       // }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        setBackBarButton()
        self.title = "PROFILE".localized
        requestToGetProfile()
    }

    func  requestToGetProfile()  {
        startAnimating()
        ProfileManager().getProfile { [weak self] (response, error) in
            if self?.checkResponse(response: response, error: error) ?? false{
                self?.user = response?.data
                self?.loadDataOnUI()
            }
        }
        
        
//        ProfileManager().getProfile { [weak self] (result) in
//            self?.stopAnimating()
//
//            switch result {
//            case .sucess(let root):
//                self?.user = root.data!
//                self?.loadDataOnUI()
//
////                self?.callBack!()
//            case .failure(let error):
//                self?.showError(body: error)
//            }
//        }
    }
    
    @IBAction func onClick_edit(_ sender : UIButton){
        let vc = EditCustomerProfileVC.viewController()
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }

}


