//
//  SettingVC.swift
//  TailerOnline
//
//  Created by apple on 3/5/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import UIKit
//import DLRadioButton

class SettingVC: BaseVC {

     //MARK:-  outlets
    
    @IBOutlet var passwordView: UIView!
//    @IBOutlet var passwordBtnLabel: UILabel!
    @IBOutlet var passwordTitle: UILabel!
    @IBOutlet var passwordLabel: UILabel!
    
//    @IBOutlet var languageBtnLabel: UILabel!
    @IBOutlet var languageTitle: UILabel!
    @IBOutlet var languageLabel: UILabel!
    
    @IBOutlet var currencyTitle: UILabel!
    @IBOutlet var currencyLabel: UILabel!
    
    @IBOutlet weak var aedBtn: UIButton!
    @IBOutlet weak var usdBtn: UIButton!
    
    @IBOutlet weak var btn_changePassword: UIButton!
    @IBOutlet weak var btn_changeLanguage: UIButton!
    
    static func viewController() -> SettingVC{
        
        return UIStoryboard.menuStoryboard.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        // Do any additional setup after loading the view.
    }
    
    override func setupView() {
        setLocalization()
        self.title = "SETTINGS".localized
        setBackBarButton()
        if AppSettings.currency == .usd{
            currencyUSDBtnTapped(usdBtn)
        }
        else{
            currencyAEDBtnTapped(aedBtn)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        reloadSetting()
       
        
    }
    
    
    //MARK: - Initialzation Code
    func setLocalization()  {
     
        self.aedBtn.setTitle("AED", for: .normal)
        self.usdBtn.setTitle("USD", for: .normal)
        btn_changeLanguage.setTitle("CHANGE", for: .normal)
        btn_changePassword.setTitle("CHANGE", for: .normal)
        
        self.passwordTitle.text = "Password".localized
        self.passwordLabel.text = "Change Password".localized
//        self.passwordBtnLabel.text  = "Change".localized
        
        self.languageTitle.text = "Language".localized
        self.languageLabel.text = "Change Language".localized
//        self.languageBtnLabel.text  = "Change".localized
        
        self.currencyTitle.text = "Currency".localized
        self.currencyLabel.text = "Select Currency".localized
        
        self.setViewDirectionByLanguage()
        
        
    }
    
    
    fileprivate func reloadSetting() {
        
       
//        //currency handling
//        if myDefaultCurrency == .aed {
//            self.aedBtn.isSelected = true
//        }
//        else {
//            self.usdBtn.isSelected = true
//        }
//        //account type handling
//        if(myDefaultAccount == .guest){
//            passwordView.isHidden = true
//            passwordView.heightAnchor.constraint(equalToConstant: 0).isActive = true
//        }
//        else{
//            passwordView.isHidden = false
//        }
//
       
        
    }
    
     //MARK:-  actions
    
    @IBAction func currencyAEDBtnTapped(_ sender: UIButton) {
    
        aedBtn.setImage(UIImage(named: "radiobutton_sl"), for: .normal)
        usdBtn.setImage(UIImage(named: "radiobutton_unsl"), for: .normal)
        AppSettings.shared.myCurrency = .aed
       // myDefaultCurrency = .aed
        
    }
    
    @IBAction func currencyUSDBtnTapped(_ sender: UIButton) {
      //  myDefaultCurrency = .usd
        aedBtn.setImage(UIImage(named: "radiobutton_unsl"), for: .normal)
        usdBtn.setImage(UIImage(named: "radiobutton_sl"), for: .normal)
        AppSettings.shared.myCurrency = .usd
        
    }
    
    
    @IBAction func btnChangePaswordAction(_ sender: UIButton) {
        let vc = ChangePasswordVC.viewController()
        navigationController?.pushViewController(vc, animated: true)
//        let s = AppConstant.storyBoard.userEntry
//        let vc = s.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
//        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func BtnChnageLanguageAction(_ sender: UIButton) {
        let vc = ChangeLanguageVC.viewController()
        vc.rootVC = .Setting
        navigationController?.pushViewController(vc, animated: true)
        
//        let  s = AppConstant.storyBoard.userEntry
//        let vc =  s.instantiateViewController(withIdentifier: "ChangeLanguageVC") as! ChangeLanguageVC
//        vc.comeFromSettingVC = true
//        self.navigationController?.pushViewController(vc, animated: true)
    }


}

    

    


