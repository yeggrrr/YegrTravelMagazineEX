//
//  ChatUserTableViewCell.swift
//  YegrTravelMagazineEX
//
//  Created by YJ on 6/2/24.
//

import UIKit

class ChatUserTableViewCell: UITableViewCell {
    @IBOutlet var chatContentsView: UIView!
    @IBOutlet var chatContentsLabel: UILabel!
    @IBOutlet var chatDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        chatContentsView.backgroundColor = UIColor(named: "ChatBackgroundColor")
        chatContentsView.layer.cornerRadius = 10
        chatContentsView.layer.borderWidth = 1
        chatContentsView.layer.borderColor = UIColor.darkGray.cgColor
        
        chatContentsLabel.textColor = .label
        chatContentsLabel.textAlignment = .right
        chatContentsLabel.numberOfLines = 0
        chatContentsLabel.font = .systemFont(ofSize: 14)
        
        chatDateLabel.textColor = .systemGray
        chatDateLabel.textAlignment = .right
        chatDateLabel.numberOfLines = 1
        chatDateLabel.font = .systemFont(ofSize: 12)
        chatDateLabel.font = .systemFont(ofSize: 12)
    }
    
    func configureCell(chatData: Chat) {
        chatContentsLabel.text = chatData.message
        chatDateLabel.text = longToShortDate(dateString: chatData.date)
    }
    
    let longDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd hh:mm" // 2024-06-11 09:31
        return df
    }()

    let shortDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "hh:mm a" // 09:31 오전
        return df
    }()

    // "2024-06-11 09:31" -> "09:31 오전"
    func longToShortDate(dateString: String) -> String {
        let date = longDateFormatter.date(from: dateString) ?? Date()
        return shortDateFormatter.string(from: date)
    }
}
