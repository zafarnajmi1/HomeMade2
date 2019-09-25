//
//  EmptyVC.swift
//  HomeMade2
//
//  Created by Apple on 25/06/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class EmptyVC: BaseVC {

    
    @IBOutlet weak var lbl_noData: UILabel!
    @IBOutlet weak var tbl_noData: UITableView!
    @IBOutlet weak var scrl_view: UIScrollView!
//    let refreshControl = UIRefreshControl()
    static func viewController() -> EmptyVC{
        return UIStoryboard.commonStoryboard.instantiateViewController(withIdentifier: "EmptyVC") as! EmptyVC
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl_noData.text = "No Data Available".localized
//        refreshControl.addTarget(self, action: #selector(refreshView), for: .valueChanged)
//        tbl_noData.refreshControl = refreshControl
//        tbl_noData.tableFooterView = UIView(frame: .zero)
//        tbl_noData.delegate = self
//        tbl_noData.dataSource = self

        // Do any additional setup after loading the view.
    }
    @objc func refreshView(){
        print("Refreshing empty View")
        refreshControl.beginRefreshing()
        perform(#selector(endRefresh), with: nil, afterDelay: 3)
    }
    @objc func endRefresh(){
        refreshControl.endRefreshing()
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
extension EmptyVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "temp")
        return cell!
    }
    
    
}
