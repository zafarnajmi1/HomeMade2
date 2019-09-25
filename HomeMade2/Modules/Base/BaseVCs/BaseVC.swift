//
//  BaseVC.swift
//  HomeMade2
//
//  Created by Apple on 14/05/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import BadgeHub
class BaseVC: UIViewController {
    
    
    var isLoadMore : Bool = false
    var isRequestSent : Bool = false
    var badgeHub : BadgeHub?
    static var defaultError : String{
        
            return AppSettings.defaultError
        
    }
    static var defaultSuccess : String{
        
            return AppSettings.defaultSuccess
        
    }
    var pagination : Pagination?
    var emptyVC : EmptyVC?
    var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(pullToRefreshView), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")

        // Do any additional setup after loading the view.
    }
    func setupView(){
    }
    func setupTexts(){
        
    }
    func loadDataOnUI(){
        
    }
    func addEmptyView(frame : CGRect = .zero, below : UIView? = nil, above :UIView? = nil){

      
            view.addSubview(getEmptyVC(frame: frame).view)
        
        
        
//        view.backgroundColor = .white
    }
    func removeEmptyView(){
        if let emptyVC = emptyVC{
            emptyVC.view.removeFromSuperview()
        }
        
        //        view.backgroundColor = .white
    }
    func getEmptyVC(frame : CGRect) -> EmptyVC{
     
            guard let emptyVC = emptyVC
                else {
                    
                    
                    self.emptyVC = EmptyVC.viewController()
                    if frame == .zero {
                        self.emptyVC?.view.frame = view.frame
                        
                    }
                    else{
                        self.emptyVC?.view.frame = frame
                    }
                    
                    return self.emptyVC!
            }
            return emptyVC
        
        
    }
    func updateColor(){
        view.backgroundColor = .white
    }
    @objc func pullToRefreshView(){
        
    }
    
//    var sb_storyBoard: UIStoryboard{
//        get {
//            return UIStoryboard.home
//        }
//    }
//    static func vc<T>() -> T
//    {
//        
//        return storyboard.instantiateViewController(withIdentifier: self.className) as! T
//        
//    }
    
    func showError(title: String = "Alert!".localized, body: String  ) -> Void {
        print(body)
        
        let alert = UIAlertController(title: title, message: body, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: { (action) in
            
        }))
        present(alert, animated: true) {
            
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
    
    @objc func addNotificationButton() {
//
//        self.navigationItem.setHidesBackButton(true, animated:false)
        
        //your custom view for back image with custom size
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        
        
            let notification = UIImage(named: "notification")
                imageView.image = notification
            
        
        view.addSubview(imageView)
        badgeHub = BadgeHub(view: view)
        badgeHub?.scaleCircleSize(by: 0.65)
        badgeHub?.setCircleColor(#colorLiteral(red: 0.9568627451, green: 0.6352941176, blue: 0.2078431373, alpha: 1), label: nil)
        badgeHub?.moveCircleBy(x: -3, y: 3)
//        badgeHub?.setCircleAtFrame(<#T##frame: CGRect##CGRect#>)
        badgeHub?.setCount(AppSettings.shared.unseenNotification)
//        badgeHub?.setCount(10)
        let backTap = UITapGestureRecognizer(target: self, action: #selector(moveToNotification))
        view.addGestureRecognizer(backTap)
        
        let leftBarButtonItem = UIBarButtonItem(customView: view)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    @objc func updateNotificaitonCount(){
//        if AppSettings.shared.unseenNotification == 0{
//            badgeHub?.hideCount()
//        }
//        else{
            badgeHub?.setCount(10)//(AppSettings.shared.unseenNotification)
//        }
        
//        badgeHub?.hideCount()
    }
    func cartButton() -> UIBarButtonItem{
        
        let button = navBarButton(image: "cart", action: #selector(moveToCart))
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
//
//        let cart = UIImage(named: "cart")
//        imageView.image = cart
//
//        view.addSubview(imageView)
//
//        let backTap = UITapGestureRecognizer(target: self, action: #selector(moveToCart))
//        view.addGestureRecognizer(backTap)
//
//        let cartButton = UIBarButtonItem(customView: view )
        return button
    }
    

    func navBarButton(image : String, action : Selector) -> UIBarButtonItem{
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        
        let cart = UIImage(named: image)
        imageView.image = cart
        
        view.addSubview(imageView)
        
        let backTap = UITapGestureRecognizer(target: self, action: action)
        view.addGestureRecognizer(backTap)
        
        let navButton = UIBarButtonItem(customView: view )
        return navButton
    }
    func navBarButton(title : String, action : Selector) -> UIBarButtonItem{
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
//        let label = UILabel()
//        label.text = title
//        label.textColor = .white
//
//
//
//        view.addSubview(imageView)
//
//        let backTap = UITapGestureRecognizer(target: self, action: action)
//        view.addGestureRecognizer(backTap)
//        UIBarButtonItem(title: title, style: .plain, target: self, action: action)
        let navButton = UIBarButtonItem(title: title, style: .plain, target: self, action: action)
        return navButton
    }
    func addCartButton() {
        //
        //        self.navigationItem.setHidesBackButton(true, animated:false)
        
        //your custom view for back image with custom size
        
        self.navigationItem.rightBarButtonItem = self.cartButton()
    }
    func addRightButton(image : String, action : Selector){
        let button = navBarButton(image: image, action: action)
        self.navigationItem.rightBarButtonItem = button
    }
    func addRightButton(title : String, action : Selector){
        let button = UIBarButtonItem(title: title, style: .plain, target: self, action: action)
        button.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)], for: .normal)
        self.navigationItem.rightBarButtonItem = button
    }
    @objc func moveToCart(){
        print("Moviing to Cart Screen")
        let vc = CartVC.viewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    
    }
    @objc func moveToNotification(){
        print("Moving to Notificaiton screen.")
        let vc = NotificationVC.viewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
        
    }
    func checkResponse(response : AnyObject?, error : String?, showAlert : Bool = true) -> Bool {
        isRequestSent = false
        stopAnimating()
        refreshControl.endRefreshing()
        if let error = error {
            if showAlert{
                showError(body: error)
            }
            return false
        }
        else if let response = response as? APIResponse{
            if response.success == false{
                if showAlert{
                    showError(body: response.message ?? AppSettings.defaultError)
                }
                
                return false
            }
            else{
                return true
            }
        }
        else{
            return false
        }
    }

}
