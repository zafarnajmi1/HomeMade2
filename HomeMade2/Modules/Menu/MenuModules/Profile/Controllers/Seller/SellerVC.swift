//
//  SellerVC.swift
//  HomeMade2
//
//  Created by Afrah Tayyab on 6/19/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class SellerVC: BaseVC {

    //MARK: Outlets
    @IBOutlet weak var imgStore: UIImageView!
    @IBOutlet weak var lblRatings: UILabel!
    @IBOutlet weak var lblStoreName: UILabel!
    
    @IBOutlet weak var lblStoreAddress: UILabel!
    @IBOutlet weak var lblStorePhoneNo: UILabel!
    @IBOutlet weak var lblStoreEmail: UILabel!
    @IBOutlet weak var lblStoreDetails: UILabel!
    
    //Outlets for Localization
    @IBOutlet weak var lblPhoneNo: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblAboutSupplier: UILabel!
    
    //making var to access User Model
    //var user : User?
    var user = AppSettings.loggedInUser()
   
    static func viewController() -> SellerVC{
        
        return UIStoryboard.profileStoryboard.instantiateViewController(withIdentifier: "SellerVC") as! SellerVC
    }
   
    //MARK: life Cycle...
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        //Adding Edit button on Tab Bar
//        self.addEditButton()
    }
    override func setupView() {
        setBackBarButton()
        addRightButton(image: "edit_box", action: #selector(onClick_edit))
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.title = "Profile".localized
        setBackBarButton()
        requestToGetProfile()
    }
    @objc func onClick_edit(){
                print("Moviing to Edit Profile Screen")
                let vc = EditSellerVC.viewController()
                vc.hidesBottomBarWhenPushed = true
                vc.user = user
                navigationController?.pushViewController(vc, animated: true)
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
//                self?.user = root.data
//                self?.loadDataOnUI()
//             
//            case .failure(let error):
//                self?.showError(body: error)
//            }
//        }
    }
  
    //MARK: Load the Particular Data on the field of UI
    override func loadDataOnUI() {
        if let user = user{
            
            AppSettings.shared.setLoggedInUser(user: user)
            lblStoreName.text = user.storeName
            lblStoreEmail.text = user.email
            lblStorePhoneNo.text = user.phone
            
            lblStoreAddress.text = user.address
            
            lblRatings.text = String(Double(user.averageRating!))
            lblStoreDetails.text = user.description
            imgStore.kf.setImage(with: URL(string: user.image ?? ""), placeholder: UIImage(named: "placeholder_user"))
        }
    }
    
}

extension SellerVC {
    
//    func addEditButton() {
//        self.navigationItem.rightBarButtonItem = self.editButton()
//    }
//    func editButton() -> UIBarButtonItem{
//        let button = navBarButton(image: "editpencil", action: #selector(moveToEditProfile))
//        return button
//    }
//
//    @objc func moveToEditProfile(){
//        print("Moviing to Edit Profile Screen")
//        let vc = EditSellerVC.viewController()
//        vc.hidesBottomBarWhenPushed = true
//        vc.user = user
//        navigationController?.pushViewController(vc, animated: true)
//    }
}
