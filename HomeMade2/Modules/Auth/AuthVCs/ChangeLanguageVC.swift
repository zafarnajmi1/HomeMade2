//
//  ChangeLanguageVC.swift
//  TailerOnline
//
//  Created by apple on 3/1/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import UIKit


enum ChangeLanguageRootVC {
    case Setting
    case Splash
}

class ChangeLanguageVC: BaseVC {

     //MARK:-  properties
    @IBOutlet weak var lbl_changLang: UILabel!
    @IBOutlet weak var lbl_changeLangSubtitle: UILabel!
    @IBOutlet weak var lbl_english: UILabel!
    @IBOutlet weak var img_english: UIImageView!
    @IBOutlet weak var lbl_arabic: UILabel!
    @IBOutlet weak var img_arabic: UIImageView!
    @IBOutlet weak var lbl_remember: UILabel!
    @IBOutlet weak var btn_remember: UIButton!
    @IBOutlet weak var btn_continue: UIButton!
    
    var rootVC : ChangeLanguageRootVC = .Splash
    var toggleRemember = false
    var comeFromSettingVC = false
    var selectedLanguage : LanguageType = .en
    static func viewController() -> ChangeLanguageVC{
        
        return UIStoryboard.authStoryboard.instantiateViewController(withIdentifier: "ChangeLanguageVC") as! ChangeLanguageVC
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      setupView()
    }
    override func setupView() {
        
        navigationController?.isNavigationBarHidden = false
        
        if rootVC == .Setting {
            setBackBarButton()
        }
        else{
            hideBackButton()
        }
        if AppSettings.isLanguageRemembered() {
            btn_remember.isSelected = true
        }
        else{
            btn_remember.isSelected = false
        }
        if AppSettings.shared.myLanguage == .en {
            
            onClick_english(UIButton())
        }
        else{
            onClick_arabic(UIButton())
        }
    }
    override func viewWillAppear(_ animated: Bool) {
      
        self.title = "CHANGE LANGUAGE".localized
        self.setViewDirectionByLanguage()
        
        
      
    }
    @IBAction func onClick_english(_ sender: UIButton) {
        img_arabic.image = UIImage(named: "radiobutton_unsl")
        img_english.image = UIImage(named: "checkbox_sl")
        AppSettings.shared.myLanguage = .en
        selectedLanguage = .en
//        updateView()
    }
    
    @IBAction func onClick_arabic(_ sender: UIButton) {
        
        img_arabic.image = UIImage(named: "checkbox_sl")
        img_english.image = UIImage(named: "radiobutton_unsl")
        AppSettings.shared.myLanguage = .ar
        selectedLanguage = .ar
        //        myDefaultLanguage = .ar
        //        updateView()
    }
    
    
    @IBAction func onClick_remember(_ sender: UIButton) {
        
//        rememberBtn.zoomAnimate()
        
        // let key =  rememberMyDefaultLanguageKey
        
        if AppSettings.isLanguageRemembered() {
            btn_remember.isSelected = false
            AppSettings.forgetMyLanguage()

            
            
        } else {
            btn_remember.isSelected = true
            AppSettings.rememberMyLanguage(value: selectedLanguage)
        }
        
        
//        switch toggleRemember {
//        case false:
//
////            AppUserDefault.shared.rememberdMyDefaultLanguage = myDefaultLanguage.rawValue
//        default:
//
////            AppUserDefault.shared.rememberdMyDefaultLanguage = nil
//        }
    }
    
    @IBAction func onClick_continue(_ sender: UIButton) {
        
        self.setViewDirectionByLanguage()
        
        if rootVC == .Setting {
            navigationController?.popViewController(animated: true)
//            let app = UIApplication.shared.delegate as! AppDelegate
//            app.moveToRootMainSectionsVC()
        }
        else {
            goToLoginScreen()
        }
        
    }
    
    
    func goToLoginScreen()  {
        let vc = SelectLoginVC.viewController()
        navigationController?.pushViewController(vc, animated: true)
//        let storyboard = UIStoryboard(name: "UserEntry", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "LoginOptionVC") as! LoginOptionVC
//        let nvc = sharedController?.navigationController
//        nvc?.pushViewController(vc, animated: true)
    }
    
    
    //MARK:- helpers
    
//    func updateView() {
//
//
//
//
//        switch myDefaultLanguage {
//
//        case .ar:
//
//            //active elements
//            arabicLabel.textColor = #colorLiteral(red: 0.6980392157, green: 0.5254901961, blue: 0.2352941176, alpha: 1)
//            arabicCheckMark.image = AppConstant.images.checkMarkActive
//            arabicCheckMark.zoomAnimate()
//
//            //not active elements
//            englishLabel.textColor = #colorLiteral(red: 0.1176470588, green: 0.1215686275, blue: 0.1254901961, alpha: 1)
//            englishCheckMark.image = AppConstant.images.checkMark
//
//        default: //en
//
//            //active elements
//            englishLabel.textColor = #colorLiteral(red: 0.6980392157, green: 0.5254901961, blue: 0.2352941176, alpha: 1)
//            englishCheckMark.image = AppConstant.images.checkMarkActive
//            englishCheckMark.zoomAnimate()
//
//            //not active elements
//            arabicLabel.textColor = #colorLiteral(red: 0.1176470588, green: 0.1215686275, blue: 0.1254901961, alpha: 1)
//            arabicCheckMark.image = AppConstant.images.checkMark
//
//        }
//
//
//
//    }
    
}


