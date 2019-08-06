//
//  String+NilIfEmpty.swift
//  Quickseries-API
//
//  Created by Rathish Kannan on 2019-05-17.
//  Copyright © 2019 Rathish Kannan. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var nilIfEmpty: String? {
        return self.isEmpty ? nil : self
    }
    
    func validateEmail(enteredEmail:String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
    
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }

}

extension UILabel {
    func halfColorChangeForText(fullText: String, changeColortext:String, color:UIColor) {
        let strNumber : NSString = fullText as NSString
        let range = (strNumber).range(of: changeColortext)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: color , range: range)
        self.attributedText = attribute
    }
}
