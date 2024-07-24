//
//  UIColor++.swift
//  IDOBlue
//
//  Created by lux on 2024/4/28.
//  Copyright © 2024 hedongyang. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hexInt: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hexInt >> 16) & 0xFF) / 255.0
        let green = CGFloat((hexInt >> 8) & 0xFF) / 255.0
        let blue = CGFloat(hexInt & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        guard hexString.count == 6,
              let hexInt = Int(hexString, radix: 16) else {
            return nil
        }
        self.init(hexInt: hexInt, alpha: alpha)
    }
}
