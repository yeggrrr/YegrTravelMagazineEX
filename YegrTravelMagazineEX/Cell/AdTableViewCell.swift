//
//  AdTableViewCell.swift
//  YegrTravelMagazineEX
//
//  Created by YJ on 5/27/24.
//

import UIKit

class AdTableViewCell: UITableViewCell {
    static let identifier = "AdTableViewCell"
    
    @IBOutlet var backgoundColorView: UIView!
    @IBOutlet var adLabel: UILabel!
    @IBOutlet var adBadgeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
}
