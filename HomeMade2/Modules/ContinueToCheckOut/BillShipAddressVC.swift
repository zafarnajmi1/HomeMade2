//
//  CheckOutVC.swift
//  TailerOnline
//
//  Created by apple on 3/19/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlacePicker
import MapKit
//import DLRadioButton

class AddressView : UIView {
    @IBOutlet weak var txt_firstName: UITextField!
    @IBOutlet weak var txt_lastName: UITextField!
    @IBOutlet weak var txt_address1: UITextField!
    @IBOutlet weak var txt_address2: UITextField!
    @IBOutlet weak var txt_phone: UITextField!
    @IBOutlet weak var txt_postalCode: UITextField!
    @IBOutlet weak var txt_email: UITextField!
    
    @IBOutlet weak var lbl_firstName: UILabel!
    @IBOutlet weak var lbl_lastName: UILabel!
    @IBOutlet weak var lbl_address1: UILabel!
    @IBOutlet weak var lbl_address2: UILabel!
    @IBOutlet weak var lbl_phone: UILabel!
    @IBOutlet weak var lbl_postalCode: UILabel!
    @IBOutlet weak var lbl_email: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        didLoad()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        didLoad()
//        fatalError("init(coder:) has not been implemented")
    }
    func didLoad() {
//        setupTexts()
        //Place your initialization code here
        
        //I actually create & place constraints in here, instead of in
        //updateConstraints
    }
    override func awakeFromNib() {
        setupTexts()
    }
    
    
    func setupTexts(){
        self.lbl_firstName.text = "First Name*".localized
        self.lbl_lastName.text = "Last Name*".localized
        self.lbl_email.text = "Email*".localized
        self.lbl_address1.text = "Address*".localized
        self.lbl_address2.text = "Address Line 2".localized
        self.lbl_phone.text = "Phone Number*".localized
        self.lbl_postalCode.text = "Postcode / Zip".localized
        
        self.txt_firstName.placeholder = "First Name".localized
        self.txt_lastName.placeholder = "Last Name".localized
        self.txt_email.placeholder = "Email".localized
        self.txt_address1.placeholder = "Address Line 1".localized
        self.txt_address2.placeholder = "Address Line 2".localized
        self.txt_phone.placeholder = "Phone Number".localized
        self.txt_postalCode.placeholder = "Postcode / Zip".localized
        self.txt_address1.delegate = self
        for subView in self.subviews{
            if let textField = subView as? UITextField{
                textField.addleftRightPading()
            }
        }
        
    }
    func loadData(model : Addresse){
        txt_firstName.text = model.firstName ?? ""
        txt_lastName.text = model.lastName ?? ""
        txt_email.text = model.email ?? ""
        txt_address1.text = model.address1 ?? ""
        txt_address2.text = model.address2 ?? ""
        txt_phone.text = model.phone ?? ""
        txt_postalCode.text = model.postCode ?? ""
    }
    func checkFormIsValid(title : String = "Alert!") -> Bool {
        
//        let title = "Billing Address".localized
        if  (txt_firstName.text?.isEmpty)! {
            let error = "Please enter valid first name".localized
            nvMessage.showError(title: title, body: error)
            return false
        }
        if (txt_lastName.text?.isEmpty)!  {
            let error = "Please enter valid last name".localized
            nvMessage.showError(title: title, body: error)
            return false
        }
        if isValid(email: txt_email.text!) == false {
            let error = "Please enter valid email ".localized
            nvMessage.showError(title: title, body: error)
            return false
        }
        if (txt_address1.text?.isEmpty)! {
            let error = "Please enter valid address ".localized
            nvMessage.showError(title: title, body: error)
            return false
        }
        if (txt_phone.text?.count)! < 8 || (txt_phone.text?.count)! > 15{
            let error = "Please enter valid phone number".localized
            nvMessage.showError(title: title, body: error)
            return false
        }
        
        return true
    }
    func addressParams(addressType : String) -> [String : Any]{
        return ["firstName": txt_firstName.text!,
         "lastName": txt_lastName.text!,
         "email":self.txt_email.text!,
         "address1":self.txt_address1.text!,
         "address2":self.txt_address2.text!,
         "phone": self.txt_phone.text!,
         "postCode": self.txt_postalCode.text!,
         "addressType": addressType]
    }
}
extension AddressView : UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        self.endEditing(true)
//        self.contentView.endEditing(true)
//        resignAllResponders()
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        UIViewController.topVC()?.present(placePicker, animated: true, completion: nil)
        
//        self.sharedVC?.present(placePicker, animated: true, completion: nil)
        
        return false
    }
//    func resignAllResponders(){
//        self.txt_firstName.resignFirstResponder()
//        self.txt_lastName.resignFirstResponder()
//        self.txt_email.resignFirstResponder()
////        self.txt_address1.resignFirstResponder()
//        self.txt_address2.resignFirstResponder()
//        self.txt_phone.resignFirstResponder()
//        self.txt_postalCode.resignFirstResponder()
////        self.txt_address1.delegate = self
//    }
}
extension AddressView: GMSPlacePickerViewControllerDelegate {
    
    
    
    // To receive the results from the place picker 'self' will need to conform to
    // GMSPlacePickerViewControllerDelegate and implement this code.
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        
        //in self view
//        self.location = place.coordinate
        
        
        //formate address
        if place.formattedAddress != nil {
            self.txt_address1.text = place.formattedAddress!
        }
        else {
            let coordinate = "selected coordinat: \(place.coordinate.latitude), \(place.coordinate.longitude)"
            self.txt_address1.text = "Unkown Address, \(coordinate)"
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


class BillShipAddressVC: PayPalVC  {

    
    //MARK:- outlets
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBOutlet weak var uv_shipping: AddressView!
    @IBOutlet weak var uv_billing: AddressView!
    
//    @IBOutlet weak var shippingFormViewHeight: NSLayoutConstraint! //520
    
    @IBOutlet weak var btn_payWithPaypal: UIButton!
    @IBOutlet weak var btn_payCashOnDelivery: UIButton!
    @IBOutlet weak var btn_shipToDifferentAddress: UIButton!
    @IBOutlet weak var btn_placeOrder: UIButton!
 
    //titles
    @IBOutlet weak var lbl_billingTitle: UILabel!
    @IBOutlet weak var lbl_shippingTitle: UILabel!
    @IBOutlet weak var lbl_paymentOption: UILabel!
    
    @IBOutlet weak var lc_placeOrderTopConstraint: NSLayoutConstraint!
    
    
    
    

    
    var totalAmountUsd = String()
//    var delegate : CallBackDelegate?
    
    var cartList: [CartItem]!
    var billAmount: Price!
    
    enum PaymentMethod: String {
        case cash
        case paypal
    }
    // default paypal is selected
    var selectedPaymentType = PaymentMethod.paypal
    var shipToDifferentAddress = false
    
    static func viewController() -> BillShipAddressVC{
        
        return UIStoryboard.product.instantiateViewController(withIdentifier: "BillShipAddressVC") as! BillShipAddressVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Checkout".localized
        
     
        setupView()
       
        
        
//        callBack = {
//            self.selectedPaymentType = .paypal
//            self.requestToCheckout()
//        }
    }
    
    
    override func setupView()  {
        
        setBackBarButton()
        setLocalization()
        reloadFormData()
        
        
//        btn_payWithPaypal.isSelected = true
//        btn_payCashOnDelivery.isSelected = false
//        self.shippingFormView.isHidden = true
//        self.shippingFormViewHeight.constant = 0
    }
    override func paymentSuccess() {
        self.selectedPaymentType = .paypal
        self.requestToCheckout()
    }
   

    func reloadFormData(){
        let user = AppSettings.loggedInUser()
        guard let addresses = user?.addresses else { return }

            for (index, model) in addresses.enumerated()  {
                switch index {
                case 0:
                    uv_billing.loadData(model: model)
                case 1://shipping fields
                    uv_shipping.loadData(model: model)
//                    self.firstNameShipping.text = model.firstName ?? ""
//                    self.lastNameShipping.text = model.lastName ?? ""
//                    self.emailShipping.text = model.email ?? ""
//                    self.address1Shipping.text = model.address1 ?? ""
//                    self.address2Shipping.text = model.address2 ?? ""
//                    self.phoneShipping.text = model.phone ?? ""
//                    self.postalCodeShipping.text = model.postCode ?? ""
                default:
                    print("object not found")
                }
        }
    }
    //MARK:- base intialization
    
    func setLocalization()   {
        
        self.btn_placeOrder.setTitle("Place Order".localized, for: .normal)
        self.btn_payWithPaypal.setTitle("Continue With Paypal".localized, for: .normal)
        self.btn_payCashOnDelivery.setTitle("Cash On Delivery".localized, for: .normal)
        //titles
        self.lbl_paymentOption.text = "Select Payment Option".localized
        self.lbl_billingTitle.text = "Billing Address".localized
        self.lbl_shippingTitle.text = "Ship To Different Address?".localized
     
        //billing labels
        
        
//        let tfs = [firstNameBilling,lastNameBilling, emailBilling,
//                   address1Billing,address2Billing,
//                   phoneBilling,postalCodeBilling,
//                   firstNameShipping, lastNameShipping, emailShipping,
//                   address1Shipping, address2Shipping,
//                   phoneShipping, postalCodeShipping] as [UITextField]
//        self.setTextFieldDirectionByLanguage(textFields: tfs)
    }
    


    @IBAction func onClick_payWithPaypal(_ sender: UIButton) {
        selectedPaymentType = .paypal
        btn_payWithPaypal.setImage(#imageLiteral(resourceName: "radiobutton_sl"), for: .normal)
        btn_payCashOnDelivery.setImage(#imageLiteral(resourceName: "radiobutton_unsl"), for: .normal)
        
        
    }
    @IBAction func onClick_payCashOnDelivery(_ sender: UIButton) {
        selectedPaymentType = .cash
        btn_payWithPaypal.setImage(#imageLiteral(resourceName: "radiobutton_unsl"), for: .normal)
        btn_payCashOnDelivery.setImage(#imageLiteral(resourceName: "radiobutton_sl"), for: .normal)
    }
    @IBAction func onClick_shipToDifferentAddress(_ sender: UIButton) {
        
        shipToDifferentAddress = !shipToDifferentAddress
        
//        UIView.animate(withDuration: 0.5, animations: {
////            [weak, self]
//
//
//        }) { (value) in
//
//        }
        
        UIView.animate(withDuration: 0.5, animations: {
            self.btn_shipToDifferentAddress.setImage(self.shipToDifferentAddress ? #imageLiteral(resourceName: "box_sl"):#imageLiteral(resourceName: "box_unsl"), for: .normal)
            
            if self.shipToDifferentAddress {
                self.lc_placeOrderTopConstraint.priority = UILayoutPriority(rawValue: 250)
                self.uv_shipping.isHidden = false
            }
            else{
                self.uv_shipping.isHidden = true
                self.lc_placeOrderTopConstraint.priority = UILayoutPriority(rawValue: 750)
            }
        })
        

    }
    
    
    @IBAction func onClick_placeOrder(_ sender: Any) {
        
        if checkFormIsValid() == false { return }
        
        
        
        let params = adressesParams()
        self.requestToUpdateUserAddresses(params)
        
    }
    func checkFormIsValid() -> Bool{
        if !uv_billing.checkFormIsValid(){
            return false
        }
        if !shipToDifferentAddress{
            return true
        }
        else if !uv_shipping.checkFormIsValid(){
            return false
        }
        else{
            return true
        }
    }
    func adressesParams() -> [String: Any] {
        var billing:[String: Any] = [:]
        var shipping:[String: Any] = [:]

        billing = uv_billing.addressParams(addressType: "billing")
        if  shipToDifferentAddress {
            shipping = uv_shipping.addressParams(addressType: "shipping")
        }
        else{
            shipping = uv_billing.addressParams(addressType: "shipping")
        }

        return ["addresses" : [billing,shipping]] as [String: Any]
    }
    
    func requestToUpdateUserAddresses(_ params : [String: Any] ){

        self.startAnimating()
        
        OrderManager().updateUserAddresses(params: params) { [weak self] (response, error) in
            if self?.checkResponse(response: response, error: error) ?? false{
                AppSettings.shared.setLoggedInUser(user: response?.data)
                self?.checkPaymentType()
            }
            
        }

//        OrderManager().updateUserAddresses(params: params){ (result) in
//            self.hideNvloader()
//
//            switch result {
//            case .sucess(let rootModel):
//
//                AppSettings.shared.setUser(model: rootModel.user!)
//               self.checkPaymentType()
//
//            case .failure(let error):
//                nvMessage.showError(body: error)
//            }
//        }
    }
    
    
    func checkPaymentType()  {

        if selectedPaymentType == .cash {
//            selectedPaymentType = .cash
            requestToCheckout()
        }
        else {
//            selectedPaymentType = .paypal
            moveToPaypalVC(cartList: cartList, billAmount: billAmount)
            return
        }
    }
    
    

    func requestToCheckout(){
        
        let paymentType = selectedPaymentType.rawValue
        var params = ["paymentMethod" : paymentType] as [String: Any]

        params.updateValue(billAmount.usd?.formattedAmount ?? "", forKey: "amount")
        let addresses = AppSettings.loggedInUser()?.addresses

        if let billing = addresses?.first(where: {$0.addressType == "billing"} ){
            params.updateValue(billing._id!, forKey: "billingAddressId")
        }
        if let shipping = addresses?.first(where: {$0.addressType == "shipping"} ){
            params.updateValue(shipping._id!, forKey: "shippingAddressId")
        }

        if let id = paymentId {
            params.updateValue(id, forKey: "paymentId")
        }

        self.startAnimating()
        OrderManager().checkout(params: params) { [weak self] (response, error) in
            if self?.checkResponse(response: response, error: error) ?? false{
                nvMessage.showSuccess(body: response?.message ?? AppSettings.defaultSuccess, closure: {
                    let vc = BuyerOrdersVC.viewController()
                    vc.isFromCheckout = true
                    self?.navigationController?.pushViewController(vc, animated: true)
                })
            }
        }
//        OrderManager.shared.checkout(params: params){ (result) in
//            self.hideNvloader()
//
//            switch result {
//            case .sucess(let rootModel):
//                nvMessage.showSuccess(body: rootModel.message ?? "", closure: {
//                    self.delegate?.reloadData()
//                    self.navigationController?.popViewController(animated: true)
//                })
//
//            case .failure(let error):
//                nvMessage.showError(body: error)
//            }
//        }
    }
    
}


