//
//  StoreProfileTableViewCell.swift
//  TailerOnline
//
//  Created by apple on 3/5/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import UIKit

class StoreProfileTableViewCell: UITableViewCell {

     //MARK:- outlets
    @IBOutlet weak var editProfileBtn: UIButton!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var storeNameEn: UILabel!
    @IBOutlet weak var storeNameAr: UILabel!
    //for values
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var descEn: UILabel!
    @IBOutlet weak var descAr: UILabel!
    //labels for localization

    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var descEnLabel: UILabel!
    @IBOutlet weak var descArLabel: UILabel!
    
     //MARK:- properties
    var controller: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setLocalization()
    }

    func setLocalization()  {
        editProfileBtn.setTitle("Edit Profile".localized, for: .normal)
       // descEnLabel.text = "Description".localized
        phoneLabel.text = "Phone no:".localized
        emailLabel.text = "Email:".localized
    }
    
    //MARK:- data initalazation
    func setData(model: LoginResponse)  {
        guard let user = model.data else {return}
        
//        myImage.setPath(image: user.image,
//                        placeHolder: AppConstant.placeHolders.store)
        storeNameEn.text = user.storeNameEn ?? "En"
        storeNameAr.text = user.storeNameAr ?? "Ar"
      
        email.text = user.email ?? "--"
        phone.text = user.phone ?? "--"
        address.text = user.address ?? "--"
        let en = user.descriptionEn ?? "No description added"
        if en.count == 0 {
            descEn.text = "No description added"
        }
        else {
             descEn.text = en
        }
        let ar = user.descriptionAr ?? "No description added"
        if ar.count == 0 {
            descAr.text = "No description added"
        }
        else {
            descAr.text = en
        }
       
    }
    
    
    
    @IBAction func ediprofileBtn(_ sender: UIButton) {
      
    }

}
