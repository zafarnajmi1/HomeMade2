//
//  MenuVC.swift
//  HomeMade2
//
//  Created by Apple on 23/05/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import GoogleSignIn
class MenuVC: BaseVC {
    
    @IBOutlet weak var tbl_list: UITableView!
    @IBOutlet weak var img_userImage: UIImageView!
    @IBOutlet weak var lbl_userName: UILabel!
    @IBOutlet weak var lbl_email: UILabel!
    var items : [MenuItem] = []
    static func viewController() -> MenuVC{
        
        return UIStoryboard.menuStoryboard.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadDataOnUI()
//        img_userImage.kf.setImage(
//            with: url,
//            placeholder: UIImage(named: "placeholderImage"),
//            options: [
//                .processor(processor),
//                .scaleFactor(UIScreen.main.scale),
//                .transition(.fade(1)),
//                .cacheOriginalImage
//            ])
        

        
    }
    
    override func loadDataOnUI() {
        if AppSettings.shared.isUserLoggedIn{
            let user = AppSettings.shared.loggedInUser
            
            
            
            if user?.accountType == "seller"
            {
                items = MenuItem.sellerMenu()
                lbl_userName.text = user?.storeName
            }
            else{
                items = MenuItem.buyerMenu()
                lbl_userName.text = user?.firstName
            
            }
            
            lbl_email.text = user?.email
            
            if let url = user?.image{
                img_userImage.kf.setImage(with: URL(string: url), placeholder: UIImage(named: "placeholder_user"))
            }
        }
        else{
            items = MenuItem.guestMenu()
            tbl_list.tableHeaderView = UIView(frame: .zero)
        }
        
        
    }
    override func setupView() {
        navigationItem.title = "MENU".localized
        
        
        addNotificationButton()
        addCartButton()
        tbl_list.registerCustomCell(withCellId: MenuItemCell.className)
        img_userImage.layer.cornerRadius = img_userImage.frame.width/2
        img_userImage.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        img_userImage.borderWidth = 2.0
        img_userImage.clipsToBounds = true
//        tbl_list.rowHeight = Row
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
}
extension MenuVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuItemCell.className) as! MenuItemCell
        let item = items[indexPath.row]
        cell.loadCell(item: item)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        switch item.type {
        case .profile:
            profile()
        case .myOrders:
            myOrders()
        case .ratingReviews:
            ratingAndReviews()
        case .paymentProfile:
            paymentProfile()
        case .settings:
            settings()
        case .termsAndConditions:
            termsAndCondition()
        case .privacyPolicy:
            privacyPolicy()
        case .aboutUs:
            aboutUs()
        case .contactUs:
            contactUs()
        case .logout:
            logout()
        case .login:
            login()
            
        default:
            return
        }
    }
    
    
}
extension MenuVC {
    
    func profile() {
//        tabBarController?.hidesBottomBarWhenPushed = true
        if let user = AppSettings.loggedInUser(){
            if user.accountType == "seller" {
                let vc = SellerVC.viewController()
      //          vc.user = AppSettings.loggedInUser()
                vc.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(vc, animated: true)
            }
            else{
                let vc = CustomerProfileVC.viewController()
                vc.user = AppSettings.loggedInUser()
                vc.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(vc, animated: true)
            }
            
        }
        
    }
    func myOrders() {
        if AppSettings.loggedInUser()?.accountType == "buyer"{
            let vc = BuyerOrdersVC.viewController()
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
        else{
            let vc = SellerOrdersVC.viewController()
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    func ratingAndReviews() {
        let vc = RatingReviewVC.viewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    func paymentProfile() {
        let vc = PaymentProfileVC.viewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    func settings(){
        let vc = SettingVC.viewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    func termsAndCondition(){
        let vc = TermsAndConditionVC.viewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    func privacyPolicy(){
        let vc = PrivacyPolicyVC.viewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    func aboutUs(){
        let vc = AboutUsVC.viewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    func contactUs(){
        let vc = ContactUsVC.viewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    func login(){
       
       let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.moveToLogin()
//        navigationController?.tabBarController?.navigationController?.setViewControllers([SelectLoginVC.viewController()], animated: true)
    }
    func logout()  {
        
        let alert = UIAlertController(title: "Logout?".localized, message: "Are you sure, you want to logout?".localized, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: { (action) in
            
        }))
        alert.addAction(UIAlertAction(title: "Logout".localized, style: .destructive, handler: { (action) in
            AppSettings.removeEmailPassword()
            FBLoginManager.logout()
            GoogleLoginManager.logout()
            let delegate = UIApplication.shared.delegate as! AppDelegate
            delegate.moveToLogin()
        }))
        
        present(alert, animated: true) {
            
        }
//        navigationController?.tabBarController?.navigationController?.setViewControllers([SelectLoginVC.viewController()], animated: true)
//        navigationController?.setViewControllers([SelectLoginVC.viewController()], animated: true)
    }
}
