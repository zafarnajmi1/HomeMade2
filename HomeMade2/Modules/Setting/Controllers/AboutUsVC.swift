//
//  AboutUsVC.swift
//  TailerOnline
//
//  Created by apple on 3/11/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import UIKit
import WebKit

class AboutUsVC: BaseVC {

     //MARK:-  outlets
    @IBOutlet weak var phoneImage: UIImageView!
    @IBOutlet weak var aboutUsLabel: UILabel!
    @IBOutlet weak var FollowUsLabel: UILabel!
    @IBOutlet weak var mydetail: UILabel!
    @IBOutlet weak var myPhone: UILabel!
    @IBOutlet weak var myEmail: UILabel!
    @IBOutlet weak var wkw_aboutUs: WKWebView!
    //mark properties
    let setting = AppSettings.shared.settings?.settings
    
     //MARK:- my life cycle
    static func viewController() -> AboutUsVC{
        
        return UIStoryboard.menuStoryboard.instantiateViewController(withIdentifier: "AboutUsVC") as! AboutUsVC
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupView()
    }
    override func setupView() {
        self.title = "ABOUT US".localized
        setBackBarButton()
        
        let page = AppSettings.shared.settings?.pages![2]
        let htmlString = (page?.detail)!
        
        wkw_aboutUs.loadHTMLString(htmlString, baseURL: nil)
        
//        setLocalization()
//        reloadContentView()
    }

     //MARK:-  intialzation code
    
    func setLocalization() {
        aboutUsLabel.text = "Homemade Supplier".localized
        FollowUsLabel.text = "Follow Us".localized
        
        switch myDefaultLanguage {
        case .ar:
            let image = UIImage(named: "Contact")
            let flippedImage = image?.withHorizontallyFlippedOrientation()
            phoneImage.image = flippedImage
        default: // en
            phoneImage.image = UIImage(named: "Contact")
           
           
        }
    
    }
  
    func reloadContentView()  {
        
         self.mydetail.text = setting?.aboutShortDescription ?? "--"
         self.myEmail.text = setting?.contactEmail ?? "--"
         self.myPhone.text = setting?.phone1 ?? "--"
        
        
    }

    
    @IBAction  func facebookBtnTapped(_ sender: UIButton) {
        if let url = URL(string: setting?.facebook ?? "") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    @IBAction  func googleBtnTapped(_ sender: UIButton) {
        if let url = URL(string: setting?.google ?? "") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction  func twitterBtnTapped(_ sender: UIButton) {
        if let url = URL(string: setting?.twitter ?? "") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}
