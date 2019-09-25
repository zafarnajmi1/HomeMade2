//
//  FilterVC.swift
//  HomeMade2
//
//  Created by Apple on 18/06/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import RangeSeekSlider
import GoogleMaps
import GooglePlacePicker
import MapKit

enum FilterVCRoot : Int {
    case ProductListing
    case HomeScren
    
}

class FilterVC: BaseVC {
    
    

    @IBOutlet weak var lbl_priceRange : UILabel!
    @IBOutlet weak var lbl_category : UILabel!
    @IBOutlet weak var lbl_subcategory : UILabel!
    @IBOutlet weak var lbl_suplier : UILabel!
    @IBOutlet weak var lbl_location : UILabel!
    @IBOutlet weak var lbl_maxPrice : UILabel!
    

    @IBOutlet weak var txt_keyword : UITextField!
    @IBOutlet weak var txt_category : UITextField!
    @IBOutlet weak var txt_subcategory : UITextField!
    @IBOutlet weak var txt_supplier : UITextField!
    @IBOutlet weak var txt_location : UITextField!
    @IBOutlet weak var rss_slider : RangeSeekSlider!
    
    @IBOutlet weak var btn_search : UIButton!
    
    var selectedCatIndex : Int = -1
    var selectedSubcatIndex : Int = -1
    var selectedSupplierIndex : Int = -1
    var catList : [Category] = []
    var supplierList : [BaseStore] = []
    var pkr_category = UIPickerView()
    var pkr_subcategory = UIPickerView()
    var pkr_supplier = UIPickerView()
    
    var location: CLLocationCoordinate2D?

    var rootVC : FilterVCRoot = .ProductListing
    
    weak var listingFilter : SearchProductsRequest?
    var homeFilter = SearchProductsRequest()
    

    var filter : SearchProductsRequest{
        get {
            if rootVC == .ProductListing
            {
                return listingFilter!
            }
            else{
                return homeFilter
            }
        }
    }
    
    
    
    static func viewController() -> FilterVC{
        
        return UIStoryboard.categoryStoryboard.instantiateViewController(withIdentifier: "FilterVC") as! FilterVC
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        // Do any additional setup after loading the view.
    }
    override func setupView() {
        setBackBarButton()
        navigationItem.title = "ADVANCE SEARCH".localized
        pkr_category.delegate = self
        pkr_category.dataSource = self
        pkr_subcategory.delegate = self
        pkr_subcategory.dataSource = self
        pkr_supplier.delegate = self
        pkr_supplier.dataSource = self
        txt_category.inputView = pkr_category
        txt_subcategory.inputView = pkr_subcategory
        txt_supplier.inputView = pkr_supplier
        txt_keyword.addleftRightPading()
        txt_category.addleftRightPading(right: 40)
        txt_subcategory.addleftRightPading(right: 40)
        txt_supplier.addleftRightPading(right: 40)
        txt_location.addleftRightPading(right: 40)
        txt_location.delegate = self
        let settings  = AppSettings.shared.settings?.settings
        let currentCurrency = settings?.maxPrice?.showPrice
        let maxValue = currentCurrency?.amount
        rss_slider.maxValue = CGFloat(maxValue ?? 2000)
        rss_slider.selectedMaxValue = CGFloat(maxValue ?? 2000)
        let formatedText = currentCurrency?.formattedText ?? "\(AppSettings.currency == .usd ? "$":"AED") 2000"
        lbl_maxPrice.text = formatedText
        
        setupTexts()
        fetchCategories()
        if rootVC == .HomeScren {
            txt_keyword.text = filter.keyword
        }
    }
    override func setupTexts() {
        
        txt_keyword.placeholder = "Enter Keyword...".localized
        txt_category.placeholder = "Select Category".localized
        txt_subcategory.placeholder = "Sub Category".localized
        txt_supplier.placeholder = "Supplier".localized
        txt_location.placeholder = "Street 1, AI Ain, UAE".localized
        lbl_priceRange.text = "Price Range".localized
        lbl_category.text = "Category".localized
        lbl_subcategory.text = "Sub Category".localized
        lbl_suplier.text = "Supplier".localized
        lbl_location.text = "Location".localized
        btn_search.setTitle("SEARCH".localized, for: .normal)

//        lbl_maxPrice.text = "AED 2000"

    }
    
    func fetchCategories()  {
        CategoryManager().fetchCategories() { [weak self] (response, error) in
            if let error = error {
                self?.alertMessage(message: error, completion: {
                    
                })
            }
            else{
                if response?.success ?? false{
                    self?.catList = response?.data ?? []
                    self?.pkr_category.reloadAllComponents()
                    self?.pkr_subcategory.reloadAllComponents()
                    self?.fetchStores()
                }
                else{
                    self?.alertMessage(message: response?.message ?? "Unknown Error".localized, completion: {
                        
                    })
                }
                
                
            }
        }

    }
    func fetchStores(){
        CategoryManager().fetchFilterStores { [weak self]  (response, error) in
            if let error = error {
                self?.alertMessage(message: error, completion: {
                    
                })
            }
            else{
                if response?.success ?? false{
                    self?.supplierList = response?.StoreList ?? []
                    self?.pkr_supplier.reloadComponent(0)
                }
                else{
                    self?.alertMessage(message: response?.message ?? "Unknown Error".localized, completion: {
                        
                    })
                }
                
                //                self?.tbl_cats.reloadData()
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func hideAllKeyboards(){
        txt_keyword.resignFirstResponder()
        txt_category.resignFirstResponder()
        txt_subcategory.resignFirstResponder()
        txt_location.resignFirstResponder()
        txt_supplier.resignFirstResponder()
        
    }
    @IBAction func onClick_search(_ sender : UIButton){
        
        if rootVC == .HomeScren{
            
        }
        
        filter.keyword = txt_keyword.text == "" ? nil : txt_keyword.text
        
        let min = rss_slider.selectedMinValue
        let max = rss_slider.selectedMaxValue
        
        if min == max{
            filter.maxPrice = nil
            filter.minPrice = nil
        }
        else{
            filter.minPrice = Int(min)
            filter.maxPrice = Int(max)
        }
        
//        filter?.maxPrice = 10
//        filter?.minPrice = 20
        
        if let location = location{
            filter.location = [location.longitude, location.latitude]
        }
        else{
            filter.location = nil
        }
        if selectedCatIndex == -1 {
            filter.categories = nil
        }
        else {
            let selectedCat = catList[selectedCatIndex]
            var cats = [selectedCat._id]
            if selectedSubcatIndex > -1{
                let selectedSubCat = selectedCat.children?[selectedSubcatIndex]
                cats += [selectedSubCat?._id]
                
            }
            filter.categories = cats as? [String]
            
            
        }
        
        filter.store = selectedSupplierIndex == -1 ? nil : supplierList[selectedSupplierIndex].storeID
        filter.isUpdated = true
        
        if rootVC == .ProductListing{
            navigationController?.popViewController(animated: true)
        }
        else{
            let vc = ProductListingVC.viewController()
            vc.params = filter
//            vc.onClick_filter()
            
            navigationController?.pushViewController(vc, animated: true)
        }
        
        
        
    }

}

extension FilterVC : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        hideAllKeyboards()
        
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        
        present(placePicker, animated: true, completion: nil)
        
        return false
    }
    
}
extension FilterVC : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pkr_category{
            return catList.count + 1
        }
        else if pickerView == pkr_subcategory {
            if selectedCatIndex == -1 {
                return 0
            }
            else{
                let catgory = catList[selectedCatIndex]
                if let subcat = catgory.children{
                    return subcat.count + 1
                }
                else{
                    return 0
                }
                
                
                
            }
            
        }
        else if pickerView == pkr_supplier{
            return supplierList.count + 1
        }
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == pkr_category{
            
            if row == 0 {
                return "Select Category".localized
            }
            else{
                let index = row - 1
                let cat = catList[index]
                return cat.title
            }
            
            
//            return catList.count + 1
        }
        else if pickerView == pkr_subcategory {
            if row == 0 {
                return "Select Sub Category".localized
            }
            else{
                let index = row - 1
                let cat = catList[selectedCatIndex]
                let child = cat.children?[index]
                return child?.title
            }
        }
        else if pickerView == pkr_supplier{
            
            if row == 0 {
                return "Select Supplier".localized
            }
            else{
                let index = row - 1
                let supplier = supplierList[index]
                return supplier.storeName
            }
            
            
            //            return catList.count + 1
        }
        return "-"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let index = row - 1
        
        if pickerView == pkr_category{
            selectedCatIndex = index
            if index == -1 {
               txt_category.text = ""
                
            }
            else{
                let cat = catList[index]
                txt_category.text = cat.title
                
                
            }
            resetSubCat()
        }
        else if pickerView == pkr_subcategory {
            selectedSubcatIndex = index
            if index == -1 {
                resetSubCat()
            }
            else{
                let cat = catList[selectedCatIndex]
                
                let subcat = cat.children?[index]
                txt_subcategory.text = subcat?.title
            }

        }
        else if pickerView == pkr_supplier {
            selectedSupplierIndex = index
            if index == -1 {
                txt_supplier.text = ""
                
            }
            else{
                let supplier = supplierList[index]
                txt_supplier.text = supplier.storeName
            }
            
        }
    }
    func resetSubCat(){
        txt_subcategory.text = ""
        selectedSubcatIndex = -1
        pkr_subcategory.selectRow(0, inComponent: 0, animated: false)
    }
    
    
}

extension FilterVC: GMSPlacePickerViewControllerDelegate {
    // To receive the results from the place picker 'self' will need to conform to
    // GMSPlacePickerViewControllerDelegate and implement this code.
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        
        //in self view
        self.location = place.coordinate
        
        
        //formate address
        if place.formattedAddress != nil {
            self.txt_location.text = place.formattedAddress!
        }
        else {
            let coordinate = "selected coordinat: \(place.coordinate.latitude), \(place.coordinate.longitude)"
            self.txt_location.text = "Unkown Address, \(coordinate)"
        }
        
        
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        
        print("No place selected")
    }
    
    
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        nvMessage.showError(body: "didFailAutocompleteWithError" )
    }
    
    // Show the network activity indicator.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    // Hide the network activity indicator.
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    
}
