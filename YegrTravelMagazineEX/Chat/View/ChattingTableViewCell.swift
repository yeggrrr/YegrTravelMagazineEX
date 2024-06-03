//
//  ChattingTableViewCell.swift
//  YegrTravelMagazineEX
//
//  Created by YJ on 6/1/24.
//

import UIKit

class ChattingTableViewCell: UITableViewCell {
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var chatroomNameLabel: UILabel!
    @IBOutlet var recentChatLabel: UILabel!
    @IBOutlet var recentChatDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
    }
    
    func configureUI() {
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.borderColor = UIColor(named: "ButtonColor")?.cgColor
        
        chatroomNameLabel.textAlignment = .left
        chatroomNameLabel.textColor = .label
        chatroomNameLabel.font = .boldSystemFont(ofSize: 15)
        
        recentChatLabel.textAlignment = .left
        recentChatLabel.textColor = .darkGray
        recentChatLabel.font = .systemFont(ofSize: 14)
        
        recentChatDateLabel.textAlignment = .right
        recentChatDateLabel.textColor = .systemGray
        recentChatDateLabel.font = .systemFont(ofSize: 11)
    }
    
    func configureCell(index: Int, mockChatList: [ChatRoom]) {
        let chatRoom = mockChatList[index]
        let lastChat = chatRoom.chatList.last
        if let lastChat = lastChat {
            profileImageView.image = UIImage(named: chatRoom.chatroomImage[0])
            chatroomNameLabel.text = chatRoom.chatroomName
            recentChatLabel.text = lastChat.message
            recentChatDateLabel.text = DateFormatter.longToShortDate(dateString: lastChat.date)
        }
    }
}
