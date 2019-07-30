//
//  StringExt.swift
//  LoginProject
//
//  Created by Ravi Chokshi on 25/07/19.
//  Copyright © 2019 Swapnil Patel. All rights reserved.
//

import Foundation
import UIKit
extension UITextField{
    
   
    // validate an email for the right format
    func isValidEmail() -> Bool {
        /*
         There’s some text before the @
         There’s some text after the @
         There’s at least 2 alpha characters after a .
        */
        guard self.text != nil else { return false }
        
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: self.text)
    }
    
    //password format validator.
    func isValidPassword() -> Bool {
        guard self.text != nil else { return false }
        
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 8 characters total
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return passwordTest.evaluate(with: self.text)
    }
    
    func isValidContact() -> Bool {
        
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self.text!, options: [], range: NSMakeRange(0, self.text!.count))
            if let res = matches.first {
               return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.text!.count && self.text!.count == 10
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    var isEmpty: Bool {
        
        return text?.isEmpty ?? true
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    // on key board auto next
    /*
     how to use :
     UITextField.connectFields(fields: [userNameTextField, passwordTextField])
     */
    class func connectFields(fields:[UITextField]) -> Void {
        guard let last = fields.last else {
            return
        }
        for i in 0 ..< fields.count - 1 {
            fields[i].returnKeyType = .next
            fields[i].addTarget(fields[i+1], action: #selector(UIResponder.becomeFirstResponder), for: .editingDidEndOnExit)
        }
        last.returnKeyType = .done
        last.addTarget(last, action: #selector(UIResponder.resignFirstResponder), for: .editingDidEndOnExit)
    }
}
