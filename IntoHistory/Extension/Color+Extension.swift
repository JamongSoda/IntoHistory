//
//  Color+Extension.swift
//  IntoHistory
//
//  Created by Yu ahyeon on 2022/08/10.
//

import UIKit

extension UIColor {
    static let basicBackground = UIColor.init(red: 248, green: 248, blue: 250)
    static let greenBackground = UIColor.init(red: 227, green: 236, blue: 221)
    static let mainGreenColor = UIColor.init(red: 155, green: 180, blue: 160)
    static let unknownNameGray = UIColor.init(red: 134, green: 134, blue: 134)
    static let blackboardColor1 = UIColor.init(red: 61, green: 98, blue: 104)
    static let blackboardColor2 = UIColor.init(red: 40, green: 62, blue: 74)
    static let blackboardBorder1 = UIColor.init(red: 147, green: 89, blue: 3)
    static let blackboardBorder2 = UIColor.init(red: 118, green: 71, blue: 0)
    static let blackboardEraser = UIColor.init(red: 81, green: 37, blue: 12)
    static let popupDim = UIColor(red: 0, green: 0, blue: 0, a: 0.5)
    static let inactiveButtonColor = UIColor(red: 236, green: 236, blue: 236)

    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
           self.init(
               red: CGFloat(red) / 255.0,
               green: CGFloat(green) / 255.0,
               blue: CGFloat(blue) / 255.0,
               alpha: a
           )
       }
}

extension UIView {
    func setGradient(color1:UIColor,color2:UIColor){
           let gradient: CAGradientLayer = CAGradientLayer()
           gradient.colors = [color1.cgColor,color2.cgColor]
           gradient.locations = [0.0 , 1.0]
           gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
           gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
           gradient.frame = bounds
           layer.addSublayer(gradient)
       }
}
