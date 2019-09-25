//
//  PrivacyPolicyVC.swift
//  HomeMade2
//
//  Created by Apple on 31/05/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import WebKit
class PrivacyPolicyVC: BaseVC {

    @IBOutlet weak var wkw_privacyPolicy: WKWebView!
    static func viewController() -> PrivacyPolicyVC{
        
        return UIStoryboard.menuStoryboard.instantiateViewController(withIdentifier: "PrivacyPolicyVC") as! PrivacyPolicyVC
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        // Do any additional setup after loading the view.
    }
    override func setupView() {
        setBackBarButton()
        let page = AppSettings.shared.settings?.pages![1]
        
        let htmlString = (page?.detail)!
        
        wkw_privacyPolicy.loadHTMLString(htmlString, baseURL: nil)
//        if let htmlString = AppSettings.shared.settings?.settings?.privacy
//            
//        {
//            wkw_privacyPolicy.loadHTMLString(htmlString, baseURL: nil)
//        }
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
