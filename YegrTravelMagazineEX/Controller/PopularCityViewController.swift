//
//  PopularCityViewController.swift
//  YegrTravelMagazineEX
//
//  Created by YJ on 5/27/24.
//

import UIKit
import Kingfisher
import MarqueeLabel

class PopularCityViewController: UIViewController {

    @IBOutlet var popularCityTableView: UITableView!
    
    let travelData = TravelInfo.shared.travel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "도시 상세 정보"
        popularCityTableView.delegate = self
        popularCityTableView.dataSource = self
        let xib = UINib(nibName: PopularCityTableViewCell.identifier, bundle: nil)
        popularCityTableView.register(xib, forCellReuseIdentifier: PopularCityTableViewCell.identifier)
        

    }


}

extension PopularCityViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        travelData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularCityTableViewCell.identifier, for: indexPath) as? PopularCityTableViewCell else { return UITableViewCell() }
        
        let data = TravelInfo.shared.travel[indexPath.row]
        cell.titleLabel.text = data.title
        cell.titleLabel.textColor = .label
        cell.titleLabel.font = .boldSystemFont(ofSize: 17)
        
        cell.descriptionLabel.text = data.description
        cell.descriptionLabel.textAlignment = .left
        cell.descriptionLabel.numberOfLines = 0
        cell.descriptionLabel.textColor = .darkGray
        cell.descriptionLabel.font = .systemFont(ofSize: 14)
        
        let grade = [cell.firstStarImageView, cell.secondStarImageView, cell.thirdStarImageView, cell.forthStarImageView, cell.fifthStarImageView]
        grade.forEach {
            $0?.tintColor = .systemOrange
            $0?.image = UIImage(systemName: "star")
        }
        
        let gradeData = data.grade ?? 0.0
        
        switch gradeData {
        case 0.0..<1.0:
            cell.firstStarImageView.image = UIImage(systemName: "star.leadinghalf.filled")
            cell.secondStarImageView.image = UIImage(systemName: "star")
            cell.thirdStarImageView.image = UIImage(systemName: "star")
            cell.forthStarImageView.image = UIImage(systemName: "star")
            cell.fifthStarImageView.image = UIImage(systemName: "star")
        case 1.1..<1.6:
            cell.firstStarImageView.image = UIImage(systemName: "star.fill")
            cell.secondStarImageView.image = UIImage(systemName: "star.leadinghalf.filled")
            cell.thirdStarImageView.image = UIImage(systemName: "star")
            cell.forthStarImageView.image = UIImage(systemName: "star")
            cell.fifthStarImageView.image = UIImage(systemName: "star")
        case 1.6..<2.1:
            cell.firstStarImageView.image = UIImage(systemName: "star.fill")
            cell.secondStarImageView.image = UIImage(systemName: "star.fill")
            cell.thirdStarImageView.image = UIImage(systemName: "star")
            cell.forthStarImageView.image = UIImage(systemName: "star")
            cell.fifthStarImageView.image = UIImage(systemName: "star")
        case 2.1..<2.6:
            cell.firstStarImageView.image = UIImage(systemName: "star.fill")
            cell.secondStarImageView.image = UIImage(systemName: "star.fill")
            cell.thirdStarImageView.image = UIImage(systemName: "star.leadinghalf.filled")
            cell.forthStarImageView.image = UIImage(systemName: "star")
            cell.fifthStarImageView.image = UIImage(systemName: "star")
        case 2.6..<3.1:
            cell.firstStarImageView.image = UIImage(systemName: "star.fill")
            cell.secondStarImageView.image = UIImage(systemName: "star.fill")
            cell.thirdStarImageView.image = UIImage(systemName: "star.fill")
            cell.forthStarImageView.image = UIImage(systemName: "star")
            cell.fifthStarImageView.image = UIImage(systemName: "star")
        case 3.1..<3.6:
            cell.firstStarImageView.image = UIImage(systemName: "star.fill")
            cell.secondStarImageView.image = UIImage(systemName: "star.fill")
            cell.thirdStarImageView.image = UIImage(systemName: "star.fill")
            cell.forthStarImageView.image = UIImage(systemName: "star.leadinghalf.filled")
            cell.fifthStarImageView.image = UIImage(systemName: "star")
        case 3.6..<4.1:
            cell.firstStarImageView.image = UIImage(systemName: "star.fill")
            cell.secondStarImageView.image = UIImage(systemName: "star.fill")
            cell.thirdStarImageView.image = UIImage(systemName: "star.fill")
            cell.forthStarImageView.image = UIImage(systemName: "star.fill")
            cell.fifthStarImageView.image = UIImage(systemName: "star")
        default:
            cell.firstStarImageView.image = UIImage(systemName: "star.fill")
            cell.secondStarImageView.image = UIImage(systemName: "star.fill")
            cell.thirdStarImageView.image = UIImage(systemName: "star.fill")
            cell.forthStarImageView.image = UIImage(systemName: "star.fill")
            cell.fifthStarImageView.image = UIImage(systemName: "star.leadinghalf.filled")
        }
        
        if let save = data.save {
            cell.saveLabel.text = "저장 \(save.formatted())"
            cell.saveLabel.textColor = .lightGray
            cell.saveLabel.font = .systemFont(ofSize: 14)
        }
        
        if let image = data.travel_image {
            let url = URL(string: image)
            cell.detailImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "leaf.fill"))
            cell.detailImageView.contentMode = .scaleAspectFill
            cell.detailImageView.layer.cornerRadius = 8
            cell.detailImageView.tintColor = .systemGray6
        }
        
        let heartImage = data.like ?? false ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        cell.likeButton.setImage(heartImage, for: .normal)
        cell.likeButton.tintColor = .white
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    @objc func likeButtonClicked(sender: UIButton) {
        TravelInfo.shared.travel[sender.tag].like?.toggle()
        popularCityTableView.reloadData()
    }
    
    
}
