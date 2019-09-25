//
//  TermsAndConditionVC.swift
//  HomeMadeSuppliers
//
//  Created by apple on 5/22/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import UIKit
import WebKit

class TermsAndConditionVC: BaseVC {

    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myTitle: UILabel!
    @IBOutlet weak var myDetail: UILabel!
    
    @IBOutlet weak var wkw_termsAndCondition: WKWebView!
    
    static func viewController() -> TermsAndConditionVC{
        
        return UIStoryboard.menuStoryboard.instantiateViewController(withIdentifier: "TermsAndConditionVC") as! TermsAndConditionVC
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        
    }
    override func setupView() {
        setBackBarButton()
        let page = AppSettings.shared.settings?.pages![0]
        
        let htmlString = (page?.detail)!
        
        wkw_termsAndCondition.loadHTMLString(htmlString, baseURL: nil)
        
        
//        if let htmlString = AppSettings.shared.settings?.settings?.terms
//        
//        {
//            wkw_termsAndCondition.loadHTMLString(htmlString, baseURL: nil)
//        }
        
        
    }
    
//    func reloadContentView() -> <#return type#> {
//        <#function body#>
//    }

    

}
