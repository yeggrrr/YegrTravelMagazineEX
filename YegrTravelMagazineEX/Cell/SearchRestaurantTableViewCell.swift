//
//  SearchRestaurantTableViewCell.swift
//  YegrTravelMagazineEX
//
//  Created by YJ on 5/25/24.
//

import UIKit

class SearchRestaurantTableViewCell: UITableViewCell {
    static let identifier = "SearchRestaurantTableViewCell"
    
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
        likeButton.tintColor = .white
    }
}
