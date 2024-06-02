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
    @IBOutlet var chatroomNameLabel: UILabel!
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
            recentChatDateLabel.text = longToShortDate(dateString: lastChat.date)
        }
    }
}

// TODO: 파일 분리하기
let longDateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.dateFormat = "yyyy-MM-dd hh:mm" // 2024-06-11 09:31
    return df
}()

let shortDateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.dateFormat = "yy.MM.dd" // 24.06.11
    return df
}()

// "2024-06-11 09:31" -> "24.06.11"
func longToShortDate(dateString: String) -> String {
    let date = longDateFormatter.date(from: dateString) ?? Date()
    return shortDateFormatter.string(from: date)
}

// "24.06.11" -> "2024-06-11 09:31"
func shortToLongDate(dateString: String) -> String {
    let date = shortDateFormatter.date(from: dateString) ?? Date()
    return longDateFormatter.string(from: date)
}
