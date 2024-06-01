//
//  PopularCityTableViewCell.swift
//  YegrTravelMagazineEX
//
//  Created by YJ on 5/27/24.
//

import UIKit

class PopularCityTableViewCell: UITableViewCell {
    static let identifier = "PopularCityTableViewCell"
    
    @IBOutlet var detailImageView: UIImageView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var firstStarImageView: UIImageView!
    @IBOutlet var secondStarImageView: UIImageView!
    @IBOutlet var thirdStarImageView: UIImageView!
    @IBOutlet var forthStarImageView: UIImageView!
    @IBOutlet var fifthStarImageView: UIImageView!
    @IBOutlet var saveLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        titleLabel.textColor = .label
        titleLabel.font = .boldSystemFont(ofSize: 18)
        descriptionLabel.textAlignment = .left
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .darkGray
        descriptionLabel.font = .systemFont(ofSize: 15)
        
        let grade = [firstStarImageView, secondStarImageView, thirdStarImageView, forthStarImageView, fifthStarImageView]
        grade.forEach {
            $0?.tintColor = .systemOrange
            $0?.image = ImageCollection.starEmptyImage
        }
        saveLabel.textColor = .lightGray
        saveLabel.font = .systemFont(ofSize: 14)
        detailImageView.contentMode = .scaleAspectFill
        detailImageView.layer.cornerRadius = 8
        detailImageView.tintColor = .systemGray6
        likeButton.tintColor = .white
    }
    
    func configureCell(data: Travel) {
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        
        let gradeData = data.grade ?? 0.0
        var intValue = Int(gradeData)
        var floatingValue = gradeData - Double(intValue)
        
        [firstStarImageView, secondStarImageView, thirdStarImageView, forthStarImageView, fifthStarImageView].forEach {
            if intValue > 0 {
                $0?.image = ImageCollection.starFillImage
                intValue -= 1
            } else {
                if floatingValue > 0.4 {
                    $0?.image = ImageCollection.starHalfImage
                    floatingValue = 0
                } else {
                    $0?.image = ImageCollection.starEmptyImage
                }
            }
        }
        let image = data.travel_image ?? "leaf.fill"
        let url = URL(string: image)
        let heartImage = data.like ?? false ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        saveLabel.text = data.titleDescription
        detailImageView.kf.indicatorType = .activity
        detailImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "leaf.fill"))
        likeButton.setImage(heartImage, for: .normal)
    }
}

struct ImageCollection {
    static let starFillImage = UIImage(systemName: "star.fill")
    static let starHalfImage = UIImage(systemName: "star.leadinghalf.filled")
    static let starEmptyImage = UIImage(systemName: "star")
}
