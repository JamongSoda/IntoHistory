//
//  UIView+Extension.swift
//  IntoHistory
//
//  Created by 지준용 on 2022/08/15.
//

import Foundation
import UIKit

extension UIView {
    func uiViewShadow(backgroundView: UIView) {
        backgroundView.layer.masksToBounds = true
        backgroundView.layer.borderWidth = 1
        backgroundView.layer.borderColor = UIColor.white.cgColor
        backgroundView.layer.cornerRadius = 15
        
        layer.masksToBounds = false
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize(width: 4, height: 4)
    }
}
