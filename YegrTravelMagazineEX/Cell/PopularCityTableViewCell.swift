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
            $0?.image = UIImage(systemName: "star")
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
        
        switch gradeData {
        case 0.0..<1.0:
            firstStarImageView.image = UIImage(systemName: "star.leadinghalf.filled")
            secondStarImageView.image = UIImage(systemName: "star")
            thirdStarImageView.image = UIImage(systemName: "star")
            forthStarImageView.image = UIImage(systemName: "star")
            fifthStarImageView.image = UIImage(systemName: "star")
        case 1.1..<1.6:
            firstStarImageView.image = UIImage(systemName: "star.fill")
            secondStarImageView.image = UIImage(systemName: "star.leadinghalf.filled")
            thirdStarImageView.image = UIImage(systemName: "star")
            forthStarImageView.image = UIImage(systemName: "star")
            fifthStarImageView.image = UIImage(systemName: "star")
        case 1.6..<2.1:
            firstStarImageView.image = UIImage(systemName: "star.fill")
            secondStarImageView.image = UIImage(systemName: "star.fill")
            thirdStarImageView.image = UIImage(systemName: "star")
            forthStarImageView.image = UIImage(systemName: "star")
            fifthStarImageView.image = UIImage(systemName: "star")
        case 2.1..<2.6:
            firstStarImageView.image = UIImage(systemName: "star.fill")
            secondStarImageView.image = UIImage(systemName: "star.fill")
            thirdStarImageView.image = UIImage(systemName: "star.leadinghalf.filled")
            forthStarImageView.image = UIImage(systemName: "star")
            fifthStarImageView.image = UIImage(systemName: "star")
        case 2.6..<3.1:
            firstStarImageView.image = UIImage(systemName: "star.fill")
            secondStarImageView.image = UIImage(systemName: "star.fill")
            thirdStarImageView.image = UIImage(systemName: "star.fill")
            forthStarImageView.image = UIImage(systemName: "star")
            fifthStarImageView.image = UIImage(systemName: "star")
        case 3.1..<3.6:
            firstStarImageView.image = UIImage(systemName: "star.fill")
            secondStarImageView.image = UIImage(systemName: "star.fill")
            thirdStarImageView.image = UIImage(systemName: "star.fill")
            forthStarImageView.image = UIImage(systemName: "star.leadinghalf.filled")
            fifthStarImageView.image = UIImage(systemName: "star")
        case 3.6..<4.1:
            firstStarImageView.image = UIImage(systemName: "star.fill")
            secondStarImageView.image = UIImage(systemName: "star.fill")
            thirdStarImageView.image = UIImage(systemName: "star.fill")
            forthStarImageView.image = UIImage(systemName: "star.fill")
            fifthStarImageView.image = UIImage(systemName: "star")
        default:
            firstStarImageView.image = UIImage(systemName: "star.fill")
            secondStarImageView.image = UIImage(systemName: "star.fill")
            thirdStarImageView.image = UIImage(systemName: "star.fill")
            forthStarImageView.image = UIImage(systemName: "star.fill")
            fifthStarImageView.image = UIImage(systemName: "star.leadinghalf.filled")
        }
        
        let save = data.save ?? 0
        saveLabel.text = "저장 \(save.formatted())"
        
        let image = data.travel_image ?? "leaf.fill"
        let url = URL(string: image)
        detailImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "leaf.fill"))
        
        let heartImage = data.like ?? false ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        likeButton.setImage(heartImage, for: .normal)
    }
}
