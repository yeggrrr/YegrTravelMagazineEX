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
        
        tableView.rowHeight = 540
        title = "YEGR TRAVEL"
    }
    
    func dateToString(_ date: Date) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yy년 MM월 dd일"
        return dateFormat.string(from: date)
    }
    
    func stringToDate(_ date: String) -> Date? {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyMMdd"
        return dateFormat.date(from: date)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MagazineInfo.shared.magazine.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TravelMagazineTableViewCell.identifier, for: indexPath) as?
                TravelMagazineTableViewCell else { return UITableViewCell() }
        
        let magazineInfo = MagazineInfo.shared.magazine[indexPath.row]
        let url = URL(string: magazineInfo.photo_image)
        let defaultImage = UIImage(systemName: "leaf.fill")
        
        if let date = stringToDate(magazineInfo.date) {
            let dateString = dateToString(date)
            cell.dateLabel.text = dateString
        } else {
            cell.dateLabel.text = "-"
        }
        
        cell.configureUI()
        cell.posterImageView.kf.indicatorType = .activity
        cell.posterImageView.kf.setImage(
            with: url,
            placeholder: defaultImage,
            options: [.transition(.fade(0.1)), .forceTransition]
        )
        
        cell.titleLabel.text = magazineInfo.title
        cell.subtitleLabel.text = magazineInfo.subtitle
        return cell
    }
}
