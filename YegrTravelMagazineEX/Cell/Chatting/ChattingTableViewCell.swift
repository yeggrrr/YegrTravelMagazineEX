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
    
    let profileImageList: [String] = ["Hue", "Jack", "Bran", "Den", "내옆자리의앞자리에개발잘하는친구", "심심이"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        
    }
    
    func configureCell() {
        
    }
}
