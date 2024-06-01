//
//  MagazineTableViewCell.swift
//  YegrTravelMagazineEX
//
//  Created by YJ on 5/25/24.
//

import UIKit

class MagazineTableViewCell: UITableViewCell {
    static let identifier = "MagazineTableViewCell"
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    let dateFormat = DateFormatter()
    
    func dateToString(_ date: Date) -> String {
        dateFormat.dateFormat = "yy년 MM월 dd일"
        return dateFormat.string(from: date)
    }
    
    func stringToDate(_ date: String) -> Date? {
        dateFormat.dateFormat = "yyMMdd"
        return dateFormat.date(from: date)
    }
    
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
    
    func configureCell(data: Magazine) {
        let url = URL(string: data.photo_image)
        let defaultImage = UIImage(systemName: "leaf.fill")
        posterImageView.kf.indicatorType = .activity
        posterImageView.kf.setImage(
            with: url,
            placeholder: defaultImage,
            options: [.transition(.fade(0.1)), .forceTransition]
        )
        
        titleLabel.text = data.title
        subtitleLabel.text = data.subtitle
        
        if let date = stringToDate(data.date) {
            let dateString = dateToString(date)
            dateLabel.text = dateString
        } else {
            dateLabel.text = "-"
        }
    }
}
