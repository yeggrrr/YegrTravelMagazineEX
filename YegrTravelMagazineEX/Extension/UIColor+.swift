//
//  UIColor+.swift
//  YegrTravelMagazineEX
//
//  Created by YJ on 6/3/24.
//

import UIKit

extension UIColor {
    static let adBlueColor = UIColor(named: "AdBlueColor") ?? .systemBlue
    static let adPinkColor = UIColor(named: "AdPinkColor") ?? .systemPink
    static let adGreenColor = UIColor(named: "AdGreenColor") ?? .systemGreen
    static let adPurpleColor = UIColor(named: "AdPurpleColor") ?? .systemPurple
    static let adYellowColor = UIColor(named: "AdYellowColor") ?? .systemYellow
    
    static func random() -> UIColor {
        let colorList: [UIColor] = [.adBlueColor, .adPinkColor, .adGreenColor, .adPurpleColor, .adYellowColor]
        guard let randomColor = colorList.randomElement() else { return .white }
        return randomColor
    }
}
