//
//  BaseTabbarVC.swift
//  HomeMade2
//
//  Created by Apple on 14/05/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class BaseTabbarVC: UITabBarController {

    
    
//    static func viewController() -> BaseTabbarVC{
//        let tabbar = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "BaseTabbarVC") as! BaseTabbarVC
////        let tabbar = UITabBarController()
//
//
//        return tabbar
//    }
    static func viewController() -> UITabBarController{
        let tabbar = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "BaseTabbarVC") as! UITabBarController
        //        let tabbar = UITabBarController()
        
        
        return tabbar
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
//        setTabbarItems()
        setTabbarAppearanceAndItems()
       
    }
    
    func setTabbarAppearanceAndItems() {
        //MARK:- Appearance
        
        // Sets the default color of the icon of the selected UITabBarItem and Title
        UITabBar.appearance().tintColor = UIColor.white
        tabBar.unselectedItemTintColor = .black
        
        // Sets the default color of the background of the UITabBar
        UITabBar.appearance().barTintColor = UIColor.white
        
        
        //MARK:-  Items
//        let imageList = ["home_unsl", "category_unsl", "favourite_unsl", "chat_unsl", "menu_unsl" ]
        let imageList = [(imageName:"home_unsl", title: ""),
                         (imageName:"category_unsl", title: ""),
                         (imageName:"favourite_unsl", title: ""),
                         (imageName:"chat_unsl", title: ""),
                         (imageName:"menu_unsl", title: "")]
        var tabbarItem = UITabBarItem()
        
        for (index,item) in imageList.enumerated() {
            tabbarItem = self.tabBar.items![index]
            tabbarItem.image = UIImage(named: item.imageName)
            tabbarItem.title = item.title
            tabbarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//            tabbarItem.titlePositionAdjustment = .init(horizontal: 0, vertical: -5)
        }
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setTabBarSelectedItemIndicatorAppearance()
    }
    
    func setTabBarSelectedItemIndicatorAppearance() {
        
        
        // set red as selected background color
        let numberOfItems = CGFloat(tabBar.items!.count)
        let tabBarItemSize = CGSize(width: tabBar.frame.width / numberOfItems, height: tabBar.frame.height)
        tabBar.selectionIndicatorImage = makeImageWithColorAndSize(color: #colorLiteral(red: 0.9710801244, green: 0.6898229718, blue: 0.2214611471, alpha: 1), size: tabBarItemSize)
        
        // remove default border
//        tabBar.frame.size.width = self.view.frame.width + 4
//        tabBar.frame.origin.x = -2
    }
    
    
    func makeImageWithColorAndSize(color: UIColor, size: CGSize) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    



    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
//    fileprivate func setTabbarItems() {
//        let imageList = ["home_unsl", "category_unsl", "favourite_unsl", "chat_unsl", "menu_unsl" ]
////        let imageList1 = ["home_sl", "category_sl", "favourite_sl", "chat_sl", "menu_sl" ]
//        var tabbarItem = UITabBarItem()
//
//        for (index,item) in imageList.enumerated() {
//            tabbarItem = self.tabBar.items![index]
//            let image = UIImage(named: item)?.withRenderingMode(.alwaysTemplate)
////            let image1 = UIImage(named: imageList1[index])?.withRenderingMode(.alwaysTemplate)
//            tabbarItem.image = image
////            tabbarItem.selectedImage = image1
//            tabbarItem.title = ""
//        }
//    }
    

}
extension UIImage {
    
    class func imageWithColor(color: UIColor, size: CGSize, offset: CGFloat) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height - offset)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
