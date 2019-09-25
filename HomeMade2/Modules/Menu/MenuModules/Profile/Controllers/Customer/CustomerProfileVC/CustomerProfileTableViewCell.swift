//
//  CustomerProfileTableViewCell.swift
//  TailerOnline
//
//  Created by apple on 3/5/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import UIKit

class CustomerProfileTableViewCell: UITableViewCell {

     //MARK:-  outlets
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var address: UILabel!

    //labels localization
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var editProfileBtn: UIButton!
    
     //MARK:- my properties
    var controller: UIViewController?
    
     //MARK:-  my life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setLocalization()
    }
    
    func setLocalization()  {
        self.phoneLabel.text = "Phone no:".localized
        self.genderLabel.text = "Gender:".localized
        self.addressLabel.text = "Address:".localized
        self.editProfileBtn.setTitle("Edit Profile".localized, for: .normal)
    }
    
     //MARK:- data initalazation
    func setData(model: LoginAPIResponse)  {
        guard let user = model.data else {return}
    
//        myImage.setPath(image: user.image,
//                        placeHolder: AppConstant.placeHolders.user)
        let fullName = "\(user.firstName ?? "") \(user.lastName ?? "")"
        name.text = fullName
        email.text = user.email ?? "--"
        gender.text = user.gender ?? "--"
        phone.text = user.phone ?? "--"
        address.text = user.address ?? "--"
    }
    

}
