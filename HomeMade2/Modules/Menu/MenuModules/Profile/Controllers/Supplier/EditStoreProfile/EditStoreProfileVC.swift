//
//  EditStoreProfileVC.swift
//  TailerOnline
//
//  Created by apple on 3/5/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import UIKit


class EditStoreProfileVC: UIViewController {

    //MARK:- outlets
    @IBOutlet weak var tableView: UITableView!
    
    var profileModel: LoginResponse!
    
    
    //MARK:-  my life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewWillAppear(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Edit Store Profile".localized
        setBackBarButton()
        
        
    }
    
}

extension EditStoreProfileVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditStoreProfileTableViewCell") as! EditStoreProfileTableViewCell
        cell.sharedVC = self
        cell.setData(model: profileModel)
    
        return cell
        
    }
    
}
