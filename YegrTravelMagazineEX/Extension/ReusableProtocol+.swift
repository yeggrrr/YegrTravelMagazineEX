//
//  ReusableProtocol+.swift
//  YegrTravelMagazineEX
//
//  Created by YJ on 6/3/24.
//

import UIKit

protocol ReusableProtocol: AnyObject {
    static var id: String { get }
}

extension UITableViewCell: ReusableProtocol {
    static var id: String {
        return String(describing: self)
    }
}

extension UIViewController: ReusableProtocol {
    static var id: String {
        return String(describing: self)
    }
}
