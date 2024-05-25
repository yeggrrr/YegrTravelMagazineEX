//
//  SearchRestaurantTableViewController.swift
//  YegrTravelMagazineEX
//
//  Created by YJ on 5/25/24.
//

import UIKit
import Kingfisher
import MarqueeLabel
// 한식, 카페, 중식, 분식, 일식, 경양식, 양식 -> 검색
class SearchRestaurantTableViewController: UITableViewController {
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search"
        tableView.rowHeight = 180
        tableView.keyboardDismissMode = .onDrag
        
        textfieldUI()
    }
    
    func textfieldUI() {
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: "검색어를 입력해주세요.",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        searchTextField.keyboardType = .default
        searchTextField.textColor = .label
        searchTextField.tintColor = .lightGray
        searchTextField.textAlignment = .left
        searchTextField.keyboardAppearance = .light
        searchTextField.returnKeyType = .default
        searchTextField.backgroundColor = .systemGray6
        
        searchButton.setTitle("검색", for: .normal)
        searchButton.setTitleColor(.darkGray, for: .normal)
        searchButton.backgroundColor = .systemGray6
        searchButton.layer.borderWidth = 2
        searchButton.layer.cornerRadius = 10
        searchButton.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RestaurantList.shared.restaurantArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchRestaurantTableViewCell.identifier, for: indexPath) as? SearchRestaurantTableViewCell else { return UITableViewCell() }
        
        let restaurantInfo = RestaurantList.shared.restaurantArray[indexPath.row]
        if let url = URL(string: restaurantInfo.image) {
            cell.setPosterImage(imageURL: url)
            cell.posterImageView.kf.indicatorType = .activity
            cell.posterImageView.kf.setImage(with: url,
                                             options: [.transition(.fade(0.1)), .forceTransition, .keepCurrentImageWhileLoading])
        }
        cell.posterImageView.contentMode = .scaleAspectFill
        cell.posterImageView.layer.cornerRadius = 10
        
        cell.titleLabel.text = restaurantInfo.name
        cell.titleLabel.textColor = .label
        cell.titleLabel.textAlignment = .left
        cell.titleLabel.numberOfLines = 0
        cell.titleLabel.font = .boldSystemFont(ofSize: 22)
        
        cell.addressLabel.text = restaurantInfo.address
        cell.addressLabel.textColor = .darkGray
        cell.addressLabel.textAlignment = .left
        cell.addressLabel.numberOfLines = 0
        cell.addressLabel.font = .systemFont(ofSize: 18)
        
        cell.phoneNumberLabel.text = "📞\(restaurantInfo.phoneNumber)"
        cell.phoneNumberLabel.textColor = .darkGray
        cell.phoneNumberLabel.textAlignment = .right
        cell.phoneNumberLabel.numberOfLines = 0
        cell.phoneNumberLabel.font = .boldSystemFont(ofSize: 15)
        
        cell.priceLabel.text = "₩ \(restaurantInfo.price.formatted())"
        cell.priceLabel.textColor = .darkGray
        cell.priceLabel.textAlignment = .left
        cell.priceLabel.numberOfLines = 0
        cell.priceLabel.font = .boldSystemFont(ofSize: 16)
        
        let heartImageName = RestaurantList.shared.restaurantArray[indexPath.row].like ? "heart.fill" : "heart"
        let heartImage = UIImage(systemName: heartImageName)
        cell.likeButton.setImage(heartImage, for: .normal)
        cell.likeButton.tintColor = .red
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    @objc func likeButtonClicked(sender: UIButton) {
        RestaurantList.shared.restaurantArray[sender.tag].like.toggle()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
    }
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        view.endEditing(true)
    }
}
