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
    
    let randomColor = ["AdBlueColor", "AdPinkColor", "AdGreenColor", "AdPurpleColor", "AdYellowColor"].randomElement()!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        adLabel.textAlignment = .center
        adLabel.font = .boldSystemFont(ofSize: 17)
        
        backgoundColorView.layer.cornerRadius = 20
        
        adBadgeButton.backgroundColor = .white
        adBadgeButton.setTitle("AD", for: .normal)
        adBadgeButton.setTitleColor(.darkGray, for: .normal)
        adBadgeButton.layer.cornerRadius = 8
    }
    
    func configureCell(data: Travel) {
        adLabel.text = data.title
        backgoundColorView.backgroundColor = UIColor(named: randomColor)
    }
}