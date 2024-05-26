//
//  TravelMagazineTableViewCell.swift
//  YegrTravelMagazineEX
//
//  Created by YJ on 5/25/24.
//

import UIKit

class TravelMagazineTableViewCell: UITableViewCell {
    static let identifier = "TravelMagazineTableViewCell"
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!

    func configureUI() {
        posterImageView.layer.cornerRadius = 10
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.tintColor = .systemGray6
        
        titleLabel.textColor = .label
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        titleLabel.font = .boldSystemFont(ofSize: 22)
        titleLabel.backgroundColor = .clear
        
        subtitleLabel.textColor = .darkGray
        subtitleLabel.textAlignment = .left
        subtitleLabel.numberOfLines = 0
        subtitleLabel.font = .boldSystemFont(ofSize: 16)
        subtitleLabel.backgroundColor = .clear
        
        dateLabel.textColor = .lightGray
        dateLabel.textAlignment = .right
        dateLabel.numberOfLines = 0
        dateLabel.font = .systemFont(ofSize: 15)
        dateLabel.backgroundColor = .clear
    }
}


