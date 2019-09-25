//
//  NavigatonBarBackButtonExtension.swift
//  TailerOnline
//
//  Created by apple on 3/1/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import UIKit
//import MIBadgeButton_Swift

extension UIViewController {
   
       //MARK:- Back button
    func setBackBarButton() {
        
        self.navigationItem.setHidesBackButton(true, animated:false)
        
        //your custom view for back image with custom size
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        
        switch myDefaultLanguage {
        case .ar:
            if let imgBackArrow = UIImage(named: "arrow_back_ar") {
                imageView.image = imgBackArrow
            }
        default:
            if let imgBackArrow = UIImage(named: "arrow_back_en") {
                imageView.image = imgBackArrow
            }
        }
        
        view.addSubview(imageView)
        
        let backTap = UITapGestureRecognizer(target: self, action: #selector(backToMain))
        view.addGestureRecognizer(backTap)
        
        let leftBarButtonItem = UIBarButtonItem(customView: view )
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    @objc func backToMain() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func hideNavigationBarRightBtn() {
         self.navigationController?.navigationBar.topItem?.rightBarButtonItem = nil
    }
    
     //MARK:- setup advance search Btn
    func setFilterBarButton() {
     
        //your custom view for back image with custom size
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        
        imageView.image =  UIImage(named: "Filter")
       
        view.addSubview(imageView)
//        view.zoomAnimate()
        let backTap = UITapGestureRecognizer(target: self, action: #selector(moveToAdvanceSearchVC))
        view.addGestureRecognizer(backTap)
        
        let leftBarButtonItem = UIBarButtonItem(customView: view )
        self.navigationItem.rightBarButtonItem = leftBarButtonItem
    }
    
    @objc func moveToAdvanceSearchVC() {
//        let s = AppConstant.storyBoard.main
//        let vc = s.instantiateViewController(withIdentifier: "AdvanceSearchVC") as! AdvanceSearchVC
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    
    
    
    //MARK:- setup cart Button
//    func setCartBarBtn(badge: Int?){
//
//        let  cartBadgeBtn = MIBadgeButton(type: .custom)
//        cartBadgeBtn.badgeBackgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
//        cartBadgeBtn.badgeTextColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//
//
//        if let value = badge {
//               AppUserDefault.shared.cartBadgeItems = value
//        }
//
//
//        if let total = AppUserDefault.shared.cartBadgeItems {
//            if total == 0 {
//                cartBadgeBtn.hideBadge()
//            } else {
//                cartBadgeBtn.showBadge()
//                cartBadgeBtn.badgeString = "\(total)"
//            }
//        }
//
//
//        cartBadgeBtn.verticalMargin = 0
//        cartBadgeBtn.horizontalMargin = 0
//        //change badge position
//        cartBadgeBtn.badgeEdgeInsets = UIEdgeInsets(top: 6, left: 36, bottom: 0, right:0)
//
//        cartBadgeBtn.setImage(UIImage(named: "Cart"), for: .normal)
//        cartBadgeBtn.frame =  CGRect(x: 0, y: 0, width: 50, height: 30)
//        cartBadgeBtn.addTarget(self, action: #selector(moveToCartVC), for: .touchUpInside)
//        let cartBarbtn = UIBarButtonItem(customView: cartBadgeBtn)
//
//        //add buttons to navigationsBaR RightBarButtonItems
//        self.navigationItem.setRightBarButtonItems([cartBarbtn], animated: true)
//
//    }

//    @objc func moveToCartVC() {
//        let s = AppConstant.storyBoard.cart
//        let vc = s.instantiateViewController(withIdentifier: "CartVC") as! CartVC
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    
    //MARK:- setup Login Button
    func setLoginBarButton() {
      
        //first Item
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let imageView = UIImageView(frame: containerView.frame)
        containerView.addSubview(imageView)
        imageView.image =  UIImage(named: "UserWhite")
      
    
        let tap = UITapGestureRecognizer(target: self, action: #selector(moveToLoginOptionVC))
        containerView.addGestureRecognizer(tap)
    
        let userIcon = UIBarButtonItem(customView: containerView )
        //second Item
        let containerView2 = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        let label = UILabel(frame: containerView2.frame)
        containerView2.addSubview(label)
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.adjustsFontSizeToFitWidth =  true
        label.text = "LOGIN".localized
        label.font = UIFont(name: "Lato-Bold", size: 12)
   
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(moveToLoginOptionVC))
        containerView2.addGestureRecognizer(tap2)
        
        let userTitle = UIBarButtonItem(customView: containerView2 )
        
        self.navigationItem.rightBarButtonItems = [userTitle, userIcon]
        navigationController?.navigationBar.topItem?.rightBarButtonItems = [userTitle, userIcon]
    }
    
    @objc func moveToLoginOptionVC() {
//        let delegate = UIApplication.shared.delegate as! AppDelegate
//        delegate.moveToRootLoginOptionsVC()
    }
    
   
//    func setBarbuttonsByAccountType()  {
//        switch myDefaultAccount {
//        case .customer:
//            setCartBarBtn(badge: nil)
//        case .supplier:
//            print("No bar Buttons")
//        case .guest:
//            setLoginBarButton()
//        default: // guest
//             print("No bar Buttons")
//        }
//    }
    
    
    
    
}

////MI BadgeExtend
//extension MIBadgeButton {
//    
//    func hideBadge()  {
//        self.badgeBackgroundColor = .clear
//        self.badgeTextColor = .clear
//    }
//    func showBadge()  {
//        self.badgeBackgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
//        self.badgeTextColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//    }
//}


 //MARK:-  helpers naivgationBar
extension UIViewController {
    
    func hideBackButton()  {
        self.navigationItem.setHidesBackButton(true, animated:false)
    }
    
    
    
    func hideNavigationBar(animated: Bool = false) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    func showNavigationBar(animated: Bool = false) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setRootNavigationBar(title: String )  {
        navigationController?.navigationBar.topItem?.title = title
        
    }
    
    
}
