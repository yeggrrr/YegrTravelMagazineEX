//
//  RestaurantTableViewCell.swift
//  YegrTravelMagazineEX
//
//  Created by YJ on 5/25/24.
//

import UIKit
import Kingfisher

class RestaurantTableViewCell: UITableViewCell {
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var phoneNumberLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    
    func configure() {
        posterImageView.tintColor = .systemGray6
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.cornerRadius = 10
        
        titleLabel.textColor = .label
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        titleLabel.font = .boldSystemFont(ofSize: 22)
        
        addressLabel.textColor = .darkGray
        addressLabel.textAlignment = .left
        addressLabel.numberOfLines = 0
        addressLabel.font = .systemFont(ofSize: 18)
        
        phoneNumberLabel.textColor = .darkGray
        phoneNumberLabel.textAlignment = .right
        phoneNumberLabel.numberOfLines = 0
        phoneNumberLabel.font = .boldSystemFont(ofSize: 15)
        
        priceLabel.textColor = .systemOrange
        priceLabel.textAlignment = .left
        priceLabel.numberOfLines = 0
        priceLabel.font = .boldSystemFont(ofSize: 16)
        
        let defaultImage = UIImage(systemName: "heart")
        likeButton.setImage(defaultImage, for: .normal)
        likeButton.tintColor = UIColor(named: "TextFieldBackgroundColor")
    }
    
    func configureCell(item: Restaurant) {
        let url = URL(string: item.image)
        let defaultImage = UIImage(systemName: "fork.knife")
        
        posterImageView.kf.indicatorType = .activity
        posterImageView.kf.setImage(
            with: url,
            placeholder: defaultImage,
            options: [.transition(.fade(0.1)), .forceTransition]
        )
        titleLabel.text = "\(item.name) | \(item.category)"
        addressLabel.text = item.address
        phoneNumberLabel.text = "📞\(item.phoneNumber)"
        priceLabel.text = "₩ \(item.price.formatted())"
    }
}
