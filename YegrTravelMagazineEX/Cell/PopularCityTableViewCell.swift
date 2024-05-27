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
        
    }
    
    
}
