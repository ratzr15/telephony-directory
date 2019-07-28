//
//  UIImageView+Kingfisher.swift
//  SSSApp
//
//  Created by Rathish Kannan on 6/26/19.
//  Copyright © 2019 ExampleCompany. All rights reserved.
//

import Foundation
import Kingfisher

extension UIImageView {
    
    // base load func
     func load(_ url: URL?,
                      placeholder: String = defaultPlaceholder,
                      errorPlaceholder: String = defaultPlaceholder,
                      options: KingfisherOptionsInfo = defaultOptions) {
        
        // load place holder
        let p = UIImage(named: placeholder)
        
        // error place holder
        let e = UIImage(named: errorPlaceholder)
       
        // load image now
        self.kf.setImage(with: url, placeholder: p, options: options, progressBlock: nil) { result in
            switch result {
            case .success(_):
                break
            case .failure(_):
                self.image = e
            }
        }
    }
}

public let defaultOptions: KingfisherOptionsInfo = [
    .scaleFactor(UIScreen.main.scale),
    .transition(.none),
    .cacheOriginalImage
]

public let defaultPlaceholder = "placeholder_photo"


extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
