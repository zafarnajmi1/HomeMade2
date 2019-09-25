//
//  FormValidationStringExtension.swift
//  Baqala
//
//  Created by apple on 12/19/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import Foundation


extension String {
    
    //---- ReGular Expressions ----//
    //    "^[a-z]{1,10}$" :  First name
    //    "^[a-z]$" :  Middle Initial
    //    "^[a-z']{2,10}$" : Last Name
    //    "^(0[1-9]|1[012])[-/.](0[1-9]|[12][0-9]|3[01])[-/.](19|20)\\d\\d$" : Date of Birth
    //    "[a-z]([a-z0-9]*[-_][a-z0-9][a-z0-9]*)$" : username ( must start with a letter, can include letters, numbers _ or -)
    
    
    
    func isValidInputEmail() -> (Bool){
        
        
        let emailRexExp = "^[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let pred = NSPredicate(format:"SELF MATCHES %@", emailRexExp)
        return pred.evaluate(with: self)
    }
    
    func isValidInputName () -> Bool {
        
        let regEx = "^[A-Za-z]{3,25}$"
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        return test.evaluate(with: self)
    }
    
    
    func isValidInputUsername() -> Bool{
        
        let regex =  "^[a-z]([a-z0-9]*[-_][a-z0-9][a-z0-9]*)$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", regex)
        return passwordTest.evaluate(with: self)
        
    }
    
    
}
