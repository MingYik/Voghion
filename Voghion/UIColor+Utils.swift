//
//  UIColor+Utils.swift
//  Voghion
//
//  Created by apple on 2022/9/9.
//

import UIKit

extension UIColor {
    static func hexImage(_ hexValue: Int, _ alphaValue: CGFloat) -> UIImage {
        return UIColor(hexValue, alphaValue).toImage()
    }

    static func hexImage(_ hexValue: Int) -> UIImage {
        return hexImage(hexValue, 1)
    }

    convenience init(_ hexValue: Int, _ alphaValue: CGFloat) {
        let red, green, blue: CGFloat
        blue = CGFloat(hexValue & 0x0000FF)/255.0
        green = CGFloat(((hexValue & 0x00FF00) >> 8))/255.0
        red = CGFloat(((hexValue & 0xFF0000) >> 16))/255.0
        self.init(red: red, green: green, blue: blue, alpha: alphaValue)
    }

    convenience init(_ hexValue: Int) {
        self.init(hexValue, 1)
    }

    func toImage() -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(self.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
