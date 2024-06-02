//
//  ChatPartnerTableViewCell.swift
//  YegrTravelMagazineEX
//
//  Created by YJ on 6/2/24.
//

import UIKit
import Kingfisher

class ChatPartnerTableViewCell: UITableViewCell {
    static let identifier = "ChatPartnerTableViewCell"
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var chatContentsLabel: UILabel!
    @IBOutlet var chatDateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    }
    
    func configureUI() {
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.borderColor = UIColor.systemGray.cgColor
        
        userNameLabel.textColor = .label
        userNameLabel.textAlignment = .left
        userNameLabel.numberOfLines = 1
        userNameLabel.font = .boldSystemFont(ofSize: 15)
        
        chatContentsLabel.textColor = .darkGray
        chatContentsLabel.textAlignment = .left
        chatContentsLabel.numberOfLines = 0
        chatContentsLabel.font = .systemFont(ofSize: 14)
        chatContentsLabel.layer.cornerRadius = 1
        chatContentsLabel.layer.borderWidth = 1
        chatContentsLabel.layer.borderColor = UIColor.darkGray.cgColor
        
        chatDateLabel.textColor = .systemGray3
        chatDateLabel.textAlignment = .right
        chatDateLabel.numberOfLines = 1
        chatDateLabel.font = .systemFont(ofSize: 12)
    }
    
    func configureCell(chatData: Chat) {
        let image = chatData.user.profileImageName
        profileImageView.image = UIImage(named: image)
        
        userNameLabel.text = chatData.user.name
        chatContentsLabel.text = chatData.message
        chatDateLabel.text = chatData.date
    }
    
    
}
