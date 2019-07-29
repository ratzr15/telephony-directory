//
//  String+NilIfEmpty.swift
//  Quickseries-API
//
//  Created by Thiago Magalhaes on 2019-05-17.
//  Copyright © 2019 Thiago Magalhaes. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var nilIfEmpty: String? {
        return self.isEmpty ? nil : self
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
