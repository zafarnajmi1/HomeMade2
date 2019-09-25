//
//  ProductDetailDropDownCell.swift
//  HomeMade2
//
//  Created by Apple on 19/06/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit




class OptionView: UIView {
    var lbl_title: UILabel = UILabel()
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
//    init() {
//        super.init()
//    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        lbl_title.frame = self.bounds
        lbl_title.font = UIFont.boldSystemFont(ofSize: 16.0)
        
//        lbl_title.text = "asdfas dfasdf adsf"
        lbl_title.textAlignment = .center
        
        addSubview(lbl_title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var enableOption : Bool {
        set {
            if newValue == false{
                lbl_title.textColor = .gray
            }
            else{
                lbl_title.textColor = .black
            }
        }
        get {
            return true
        }
        
    }
    
    
}
class ProductDetailDropDownCell: ProductDetailOptionBaseCell {
    
//    @IBOutlet weak var lbl_title : UILabel!
    @IBOutlet weak var txt_input : UITextField!
    
    var pkr_picker = UIPickerView()
//    weak var productDetails : ProductDetail?
//    weak var priceable : Priceables?

    override func awakeFromNib() {
        super.awakeFromNib()
        pkr_picker.delegate = self
        pkr_picker.dataSource = self
        txt_input.inputView = pkr_picker
        txt_input.delegate = self
        txt_input.addleftRightPading(right: 40)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func loadCell(object: Priceables1, delegate: ProductDetailOptionDelegate?) {
        super.loadCell(object: object, delegate: delegate)
        pkr_picker.reloadAllComponents()
        
        if let index = priceable?.selectedIndex {
            pkr_picker.selectRow(index, inComponent: 0, animated: false)
        }
        else if (priceable?.characteristics?.count ?? 0) > 0{
            txt_input.text = ""
            pkr_picker.selectRow(0, inComponent: 0, animated: false)
        }
    }
    
//    func loadCell(object: Priceables) {
//        priceable = object
//        lbl_title.text = object.feature?.title
//        
//    }
    
}
extension ProductDetailDropDownCell : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "" {
            if (priceable?.characteristics?.count ?? 0) > 0{
                loadCharactricstic(row: pkr_picker.selectedRow(inComponent: 0))
//                let chart = priceable?.characteristics?[pkr_picker.selectedRow(inComponent: 0)]
//                txt_input.text = chart?.title
//                pkr_picker.selectRow(1, inComponent: 0, animated: false)
            }
            
        }
    }
}
extension ProductDetailDropDownCell : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return priceable?.characteristics?.count ?? 0
    }
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        
//        
//        let charact = priceable?.characteristics?[row]
//        return charact?.title
//    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = pickerOptionView(view: view)
        let charact = priceable?.characteristics?[row]
        view.enableOption = false
        view.lbl_title.text = charact?.title
        return view
        
    }
    
    func pickerOptionView(view: UIView?) -> OptionView{
        if let view = view as? OptionView{
            return view
        }
        return OptionView(frame: CGRect(x: 0, y: 0, width: AppSettings.screenWidth, height: 35))
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        loadCharactricstic(row : row)
    }
    func loadCharactricstic(row : Int){
        priceable?.selectedIndex = row
        let charact = priceable?.characteristics?[row]
        txt_input.text = charact?.title
        delegate?.featureSelected(object: priceable!, charactistic: charact!, index: row)
    }
    
    
}
