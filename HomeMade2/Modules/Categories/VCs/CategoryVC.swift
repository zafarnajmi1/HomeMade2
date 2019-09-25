//
//  CategoryVC.swift
//  HomeMade2
//
//  Created by Apple on 13/06/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class CategoryVC: BaseVC {
    
    
    @IBOutlet weak var tbl_cats : UITableView!
    var catList : [Category] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        // Do any additional setup after loading the view.
    }
    override func setupView() {
        NotificationCenter.default.addObserver(self, selector: #selector(addNotificationButton), name: NSNotification.Name(rawValue: NOTIFICATIONS_UPDATED), object: nil)
        addNotificationButton()
        addCartButton()
        navigationItem.title = "CATEGORIES".localized

        tbl_cats.register(SubcategoryCell.nib, forCellReuseIdentifier: SubcategoryCell.className)
        tbl_cats?.register(CategoryHeader.nib, forHeaderFooterViewReuseIdentifier: CategoryHeader.className)
        fetchCategories()
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: - Network
    func fetchCategories()  {
        startAnimating()
        CategoryManager().fetchCategories() { [weak self] (response, error) in
            self?.stopAnimating()
            if let error = error {
                self?.alertMessage(message: error, completion: {
                    
                })
            }
            else{
                if response?.success ?? false{
                    self?.catList = response?.data ?? []
                    self?.tbl_cats.reloadData()
                }
                else{
                    self?.alertMessage(message: response?.message ?? "Unknown Error".localized, completion: {
                        
                    })
                }
                
                
            }
        }
    }

}
extension CategoryVC : UITableViewDataSource, UITableViewDelegate, CategoryHeaderDelegate{
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CategoryHeader.className) as? CategoryHeader{
            
            let category = catList[section]
            
            headerView.loadHeaderView(object: category, section: section)
            if category.isSelected ?? false {

                headerView.img_upDown.image = UIImage(named: "dropdown_up")
            }
            else{
                headerView.img_upDown.image = UIImage(named: "dropdown")
            }
            headerView.delegate = self
            return headerView
        }
        else{
            return UIView()
        }
       
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return catList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let category = catList[section]
        if category.isSelected ?? false {
            return category.children?.count ?? 0
        }
        else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SubcategoryCell.className) as? SubcategoryCell  else { return UITableViewCell() }
        let category = catList[indexPath.section]
        if let subCat = category.children?[indexPath.row] {
            cell.loadCell(object: subCat)
            
            if  (category.children?.count)! - 1 == indexPath.row {
                cell.setBottomShadow(value: true)
            }
            else{
                cell.setBottomShadow(value: false)
            }
            
            
        }
        
        
        
        return cell
    }
    func toggleSection(header: CategoryHeader, section: Int) {
        let category = catList[section]
        if category.isSelected ?? false {
            category.isSelected = false
            header.img_upDown.image = UIImage(named: "dropdown")
        }
        else{
            category.isSelected = true
            header.img_upDown.image = UIImage(named: "dropdown_up")
        }
        
        tbl_cats.beginUpdates()
        tbl_cats.reloadSections([section], with: .fade)
        tbl_cats.endUpdates()
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ProductListingVC.viewController()
        
        let category = catList[indexPath.section]
        
        vc.category = category
        vc.subCat = category.children?[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

