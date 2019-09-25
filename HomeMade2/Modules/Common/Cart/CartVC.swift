//
//  CartVC.swift
//  HomeMade2
//
//  Created by Apple on 10/06/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class CartVC: BaseVC {

    static func viewController() -> CartVC{
        
        return UIStoryboard.commonStoryboard.instantiateViewController(withIdentifier: "CartVC") as! CartVC
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    override func setupView() {
        setBackBarButton()
    }
    


}
