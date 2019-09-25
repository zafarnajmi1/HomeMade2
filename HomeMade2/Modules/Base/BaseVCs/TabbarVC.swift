//
//  TabbarVC.swift
//  test
//
//  Created by Apple on 12/06/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class TabbarVC: UITabBarController {
    
    static func viewController() -> TabbarVC{
        
        var identifier = ""
//        if AppSettings.loggedInUser()?.accountType == "seller"{
//            identifier = "TabbarVCSeller"
//        }
//        else{
            identifier = "TabbarVC"
//        }
        
        
        return UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: identifier) as! TabbarVC
    }
    
    override func viewDidLoad() {
        
        setTabbarAppearanceAndItems()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    func setTabbarAppearanceAndItems() {
        
        //MARK:- Appearance
        
        // Sets the default color of the icon of the selected UITabBarItem and Title
        UITabBar.appearance().tintColor = UIColor.white
        tabBar.unselectedItemTintColor = UIColor(red: 203, green: 204, blue: 205)
        
        // Sets the default color of the background of the UITabBar
        UITabBar.appearance().barTintColor = UIColor.white
        
        
        //MARK:-  Items
        let imageList = [(imageName:"home_unsl", title: "aa"),
                         (imageName:"category_unsl", title: "bb"),
                         (imageName:"favourite_unsl", title: "cc"),
                         (imageName:"chat_unsl", title: "dd"),
                         (imageName:"menu_unsl", title: "ee")]
        var tabbarItem = UITabBarItem()
        
        for (index,item) in imageList.enumerated() {
            tabbarItem = self.tabBar.items![index]
            tabbarItem.image = UIImage(named: item.imageName)
//            var insets = tabbarItem.imageInsets
//            insets.top = 5
//            insets.bottom = -5
            tabbarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
//            print("Image Insets \(insets)")
//            tabbarItem.titlePositionAdjustment = .init(horizontal: 0, vertical: -5)
        }
        
        setBackgroundShadow()
        setSepratorInTabItems()
    }
    
    func setBackgroundShadow()  {
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 6
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.2
    }
    
    
    
    func setSepratorInTabItems() {
        guard let items = self.tabBar.items else {
            return
        }
        
        
        //Get the height of the tab bar
        let tabBarHeight = self.tabBar.bounds.size.height
        
        //Calculate the size of the items
        
        let totalItems = CGFloat(items.count)
        let itemWidth = (tabBar.frame.width + 4) / totalItems
        let itemHeight = tabBar.frame.height
        let itemSize = CGSize(width: itemWidth,height: itemHeight)
        
        for (index, _) in items.enumerated() {
            
            //We don't want a separator on the left of the first item.
            
            if index > 0 {
                
                //Xposition of the item
                
                let xPosition = itemSize.width * CGFloat(index)
                
                /* Create UI view at the Xposition,
                 with a width of 0.5 and height equal
                 to the tab bar height, and give the
                 view a background color
                 */
                let separator = UIView(frame: CGRect(
                    x: xPosition + 0.6, y: 0, width: 0.5, height: tabBarHeight))
                separator.backgroundColor = UIColor.lightGray
                tabBar.insertSubview(separator, at: 1)
            }
        }
        
    }
    
    
    
    override func viewDidLayoutSubviews() {
        setTabBarSelectedItemIndicatorAppearance()
    }
    
    func setTabBarSelectedItemIndicatorAppearance() {
        
        
        // set red as selected background color
        let numberOfItems = CGFloat(tabBar.items!.count)
        let tabBarItemSize = CGSize(width: tabBar.frame.width / numberOfItems, height: tabBar.frame.height)
        tabBar.selectionIndicatorImage = makeImageWithColorAndSize(color: #colorLiteral(red: 0.9710801244, green: 0.6898229718, blue: 0.2214611471, alpha: 1), size: tabBarItemSize)
        
        // remove default border
        tabBar.frame.size.width = self.view.frame.width + 4
        tabBar.frame.origin.x = -2
    }
    
    
    func makeImageWithColorAndSize(color: UIColor, size: CGSize) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    
}
