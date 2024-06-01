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
    
    func configureUI() {
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    }
    
    func configureCell(index: Int) {
        let userList = User.allCases
        let imageName = userList[index].rawValue
        profileImageView.image = UIImage(named: imageName)
        
        nicknameLabel.text = userList[index].rawValue
    }
}
