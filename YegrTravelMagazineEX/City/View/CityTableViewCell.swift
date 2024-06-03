//
//  CityTableViewCell.swift
//  YegrTravelMagazineEX
//
//  Created by YJ on 5/29/24.
//

import UIKit
import Kingfisher

class CityTableViewCell: UITableViewCell {
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var cityBackgroundView: UIView!
    @IBOutlet var travelDestinationNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }

    func configureUI() {
        mainImageView.contentMode = .scaleAspectFill
        
        mainImageView.layer.cornerRadius = 15
        mainImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        mainImageView.layer.masksToBounds = true
        
        cityBackgroundView.layer.cornerRadius = 15
        cityBackgroundView.layer.maskedCorners = .layerMaxXMaxYCorner
        cityBackgroundView.layer.masksToBounds = true
        
        cityNameLabel.textColor = .white
        cityNameLabel.textAlignment = .right
        cityNameLabel.font = .boldSystemFont(ofSize: 17)
        
        travelDestinationNameLabel.textColor = .white
        travelDestinationNameLabel.textAlignment = .left
        travelDestinationNameLabel.font = .systemFont(ofSize: 14)
    }
    
    func configureCell(data: City) {
        let image = data.city_image
        guard let url = URL(string: image) else { return }
        mainImageView.kf.indicatorType = .activity
        mainImageView.kf.setImage(with: url)
        cityNameLabel.text = "\(data.city_name) | \(data.city_english_name)"
        travelDestinationNameLabel.text = data.city_explain
    }
}
