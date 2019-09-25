//
//  CellExtensions.swift
//  HomeMade2
//
//  Created by Apple on 14/06/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

extension UITableViewCell{
    static var nib:UINib{
        return UINib(nibName: self.className, bundle: nil)
    }
//    func loadCell(object : Any){
//        
//    }
}
extension UITableViewHeaderFooterView{
    static var nib:UINib{
        return UINib(nibName: self.className, bundle: nil)
    }
}
extension UICollectionViewCell{
    static var nib:UINib{
        return UINib(nibName: self.className, bundle: nil)
    }
    func loadCell(object : Any){
        
    }
}
