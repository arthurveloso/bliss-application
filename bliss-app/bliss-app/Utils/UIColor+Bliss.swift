//
//  UIColor+Bliss.swift
//  bliss-app
//
//  Created by Arthur Veloso Gouveia Melo on 29/12/20.
//  Copyright © 2020 Arthur Veloso Gouveia Melo. All rights reserved.
//

import UIKit

extension UIColor {
    
    fileprivate convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    public convenience init(hexadecimal: Int, alpha: CGFloat) {
        self.init(red: (hexadecimal >> 16) & 0xff,
                  green: (hexadecimal >> 8) & 0xff,
                  blue: hexadecimal & 0xff,
                  alpha: alpha)
    }
    
    public static var blissDark: UIColor {
        return UIColor(hexadecimal: 0x323232, alpha: 1.0)
    }
    
    public static var blissRed: UIColor {
        return UIColor(hexadecimal: 0xFF1E56, alpha: 1.0)
    }
    
    public static var blissMustard: UIColor {
        return UIColor(hexadecimal: 0xFFAC41, alpha: 1.0)
    }
}
