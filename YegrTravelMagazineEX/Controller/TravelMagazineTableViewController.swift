//
//  TravelMagazineTableViewController.swift
//  YegrTravelMagazineEX
//
//  Created by YJ on 5/25/24.
//

import UIKit
import Kingfisher

class TravelMagazineTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 470
        title = "YEGR TRAVEL"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MagazineInfo.shared.magazine.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TravelMagazineTableViewCell.identifier, for: indexPath) as? TravelMagazineTableViewCell else { return UITableViewCell() }
        
        let magazineInfo = MagazineInfo.shared.magazine[indexPath.row]
        if let url = URL(string: magazineInfo.photo_image) {
            cell.setPosterImage(imageURL: url)
            cell.posterImageView.kf.indicatorType = .activity
            cell.posterImageView.kf.setImage(with: url,
                                  options: [.transition(.fade(2)), .forceTransition, .keepCurrentImageWhileLoading])
        }
        cell.posterImageView.layer.cornerRadius = 10
        cell.posterImageView.contentMode = .scaleAspectFill
        
        cell.titleLabel.text = magazineInfo.title
        cell.titleLabel.textColor = .black
        cell.titleLabel.textAlignment = .left
        cell.titleLabel.numberOfLines = 0
        cell.titleLabel.font = .boldSystemFont(ofSize: 22)
        cell.titleLabel.backgroundColor = .clear
        
        cell.subtitleLabel.text = magazineInfo.subtitle
        cell.subtitleLabel.textColor = .darkGray
        cell.subtitleLabel.textAlignment = .left
        cell.subtitleLabel.numberOfLines = 0
        cell.subtitleLabel.font = .boldSystemFont(ofSize: 16)
        cell.subtitleLabel.backgroundColor = .clear
        
        if let date = stringToDate(magazineInfo.date) {
            let dateString = dateToString(date)
            cell.dateLabel.text = dateString
        } else {
            cell.dateLabel.text = "-"
        }
        cell.dateLabel.textColor = .lightGray
        cell.dateLabel.textAlignment = .right
        cell.dateLabel.numberOfLines = 0
        cell.dateLabel.font = .systemFont(ofSize: 15)
        cell.dateLabel.backgroundColor = .clear

        return cell
    }
    
    func dateToString(_ date: Date) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yy년 MM월 dd일"
        return dateFormat.string(from: date)
    }
    
    func stringToDate(_ date: String) -> Date? {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyMMdd" // 240101
        return dateFormat.date(from: date)
    }
}
