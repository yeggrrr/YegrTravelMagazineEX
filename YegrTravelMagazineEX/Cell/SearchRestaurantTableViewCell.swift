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
    
    func setPosterImage(imageURL: URL) {
        DispatchQueue.global().async { [ weak self ] in
            if let data = try? Data(contentsOf: imageURL), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.posterImageView.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self?.posterImageView.image = UIImage(systemName: "fork.knife")
                    self?.posterImageView.tintColor = .lightGray
                }
            }
        }
    }
}
