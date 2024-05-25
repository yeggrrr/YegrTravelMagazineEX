//
//  TravelMagazineTableViewCell.swift
//  YegrTravelMagazineEX
//
//  Created by YJ on 5/25/24.
//

import UIKit

class TravelMagazineTableViewCell: UITableViewCell {
    static let identifier = "TravelMagazineTableViewCell"
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!

    func setPosterImage(imageURL: URL) {
        DispatchQueue.global().async { [ weak self ] in
            if let data = try? Data(contentsOf: imageURL), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.posterImageView.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self?.posterImageView.image = UIImage(systemName: "leaf.fill")
                    self?.posterImageView.tintColor = .lightGray
                }
            }
        }
    }
}


