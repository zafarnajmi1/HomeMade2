//
//  StoreProfileVC.swift
//  TailerOnline
//
//  Created by apple on 3/5/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import UIKit



class StoreProfileVC: UIViewController {

    //MARK:- outlets
    @IBOutlet weak var tableView: UITableView!
    
     //MARK:- properties
    var profileModel = LoginResponse()
    var callBack: (()-> Void)?
     //MARK:- life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewWillAppear(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackBarButton()
        self.title = "Store Profile".localized
        requestToGetProfile()
    }
    
    func  requestToGetProfile()  {
        showNvLoader()
        ProfileManager.shared.getProfile { (result) in
            self.hideNvloader()
            
            switch result {
            case .sucess(let root):
                self.profileModel = root
                self.tableView.reloadData()
                self.callBack!()
            case .failure(let error):
                self.tableView.setEmptyView(message: error)
            }
        }
    }
    
}

extension StoreProfileVC : UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileModel.message == nil ? 0:1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreProfileTableViewCell") as! StoreProfileTableViewCell
        cell.controller = self
        cell.setData(model: profileModel)
        
         //MARK:-  actions
//        cell.editProfileBtn.onTap {
//            let board = UIStoryboard(name: "Profile", bundle: nil)
//            let vc = board.instantiateViewController(withIdentifier: "EditStoreProfileVC") as! EditStoreProfileVC
//            vc.profileModel = self.profileModel
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
       
        
        return cell
    }
    
    
}
