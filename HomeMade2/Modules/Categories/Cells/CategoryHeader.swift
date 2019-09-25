//
//  CategoryHeader.swift
//  HomeMade2
//
//  Created by Apple on 13/06/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
protocol CategoryHeaderDelegate: class {
    func toggleSection(header: CategoryHeader, section: Int)
}
class CategoryHeader: UITableViewHeaderFooterView {

    
    @IBOutlet weak var lbl_name : UILabel!
    @IBOutlet weak var img_bg : UIImageView!
    @IBOutlet weak var img_upDown : UIImageView!
    var section: Int = 0
    weak var delegate: CategoryHeaderDelegate?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHeader)))
    }
//    static var nib:UINib{
//        return UINib(nibName: self.className, bundle: nil)
//    }
    func loadHeaderView(object : Category, section : Int){
        self.section = section
        lbl_name.text = object.title
        img_bg.kf.setImage(with: URL(string: object.image ?? ""), placeholder: PlaceHolder.hms_placeHolder_large)
        lbl_name.textDropShadow()
//        img_bg.kf.setImage(url)
    }
    
    @objc private func didTapHeader() {
        
        delegate?.toggleSection(header: self, section: section)
    }

}
