//
//  DateSeparatorTableViewCell.swift
//  YegrTravelMagazineEX
//
//  Created by YJ on 6/3/24.
//

import UIKit

class DateSeparatorTableViewCell: UITableViewCell {
    @IBOutlet var leftSeparatorView: UIView!
    @IBOutlet var rightSeparatorView: UIView!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
 
    func configureUI() {
        leftSeparatorView.backgroundColor = .systemGray
        rightSeparatorView.backgroundColor = .systemGray
        dateLabel.textColor = .systemGray
        dateLabel.textAlignment = .center
        dateLabel.font = .systemFont(ofSize: 14)
    }
    
    func configureCell(chatData: Chat) {
        dateLabel.text = DateFormatter.longDataToFullDate(dateString: chatData.date)
    }
}
