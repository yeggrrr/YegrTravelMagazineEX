//
//  ChattingTableViewCell.swift
//  YegrTravelMagazineEX
//
//  Created by YJ on 6/1/24.
//

import UIKit

class ChattingTableViewCell: UITableViewCell {
    static let identifier = "ChattingTableViewCell"
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nicknameLabel: UILabel!
    @IBOutlet var recentChatLabel: UILabel!
    @IBOutlet var recentChatDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
    }
    
    func configureUI() {
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.borderColor = UIColor.lightGray.cgColor
        
        nicknameLabel.textAlignment = .left
        nicknameLabel.textColor = .label
        nicknameLabel.font = .boldSystemFont(ofSize: 17)
        
        recentChatLabel.textAlignment = .left
        recentChatLabel.textColor = .darkGray
        recentChatLabel.font = .systemFont(ofSize: 15)
        
        recentChatDateLabel.textAlignment = .right
        recentChatDateLabel.textColor = .systemGray2
        recentChatDateLabel.font = .systemFont(ofSize: 12)
    }
    
    func configureCell(index: Int) {
        let userList = User.allCases
        let imageName = userList[index].rawValue
        profileImageView.image = UIImage(named: imageName)
        
        nicknameLabel.text = userList[index].rawValue
    }
}
