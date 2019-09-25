//
//  NvLoader.swift
//  Baqala
//
//  Created by apple on 1/16/19.
//  Copyright © 2019 My Technology. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

extension UIViewController: NVActivityIndicatorViewable {
    //MARK:- LodingMessage
    func showNvLoader() {
        self.startAnimating(nil, message:nil, messageFont: UIFont.systemFont(ofSize: 10), type: NVActivityIndicatorType.ballTrianglePath, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))

    }
    
    func hideNvloader() {
       self.stopAnimating()
    }
}
