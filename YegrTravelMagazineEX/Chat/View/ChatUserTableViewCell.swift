//
//  ChatUserTableViewCell.swift
//  YegrTravelMagazineEX
//
//  Created by YJ on 6/2/24.
//

import UIKit

class ChatUserTableViewCell: UITableViewCell {
    static let identifier = "ChatUserTableViewCell"
    
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
        chatDateLabel.text = chatData.date
    }
    
}
