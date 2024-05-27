//
//  SearchRestaurantTableViewController.swift
//  YegrTravelMagazineEX
//
//  Created by YJ on 5/25/24.
//

import UIKit
import Kingfisher
import MarqueeLabel

class SearchRestaurantTableViewController: UITableViewController {
    // MARK: UI
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    
    // MARK: Properties
    var searchList: [Restaurant] = []
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        initailzedData()
    }
    
    // MARK: Configure
    func configureUI() {
        // Navigation title
        title = "Search"
        
        // TableView
        tableView.keyboardDismissMode = .onDrag
        
        // TextField
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: "검색어를 입력해주세요.",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        )
        searchTextField.keyboardType = .default
        searchTextField.textColor = .label
        searchTextField.tintColor = .lightGray
        searchTextField.textAlignment = .left
        searchTextField.keyboardAppearance = .light
        searchTextField.returnKeyType = .default
        searchTextField.backgroundColor = .systemGray6
        
        // SearchButton
        searchButton.setTitle("검색", for: .normal)
        searchButton.setTitleColor(.darkGray, for: .normal)
        searchButton.backgroundColor = .systemGray6
        searchButton.layer.borderWidth = 2
        searchButton.layer.cornerRadius = 10
        searchButton.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func initailzedData() {
        searchList = RestaurantList.shared.restaurantArray
    }
    
    // MARK: Functions
    func getSearchData() {
        guard let text = searchTextField.text else { return }
        
        if text.isEmpty {
            initailzedData()
        } else {
            searchList = RestaurantList.shared.restaurantArray.filter{ $0.category == text }
            searchTextField.text = ""
            
            if searchList.isEmpty {
                let alert = UIAlertController(title: "🔔알림🔔", message: "검색 결과가 없어요! \n한식, 중식, 일식, 양식, 카페 등 카테고리를 입력해주세요.", preferredStyle: .alert)
                let checkButton = UIAlertAction(title: "확인", style: .default)
                alert.addAction(checkButton)
                present(alert, animated: true)
                initailzedData()
                searchTextField.text = ""
            }
        }
        
        tableView.reloadData()
        view.endEditing(true)
    }
    
    // MARK: Actions
    @objc func likeButtonClicked(sender: UIButton) {
        searchList[sender.tag].like.toggle()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
        for i in 0..<RestaurantList.shared.restaurantArray.count {
            let item = RestaurantList.shared.restaurantArray[i]
            if item.name == searchList[sender.tag].name {
                RestaurantList.shared.restaurantArray[i].like = searchList[sender.tag].like
                return
            }
        }
    }
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        getSearchData()
    }
}

// MARK: TableView DataSource & Delegate
extension SearchRestaurantTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchRestaurantTableViewCell.identifier, for: indexPath) as? SearchRestaurantTableViewCell else { return UITableViewCell() }
        
        let item = searchList[indexPath.row]
        let url = URL(string: item.image)
        let defaultImage = UIImage(systemName: "fork.knife")
        let heartImage = item.like ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        
        cell.configure()
        cell.posterImageView.kf.indicatorType = .activity
        cell.posterImageView.kf.setImage(
            with: url,
            placeholder: defaultImage,
            options: [.transition(.fade(0.1)), .forceTransition]
        )
        
        cell.titleLabel.text = "\(item.name) | \(item.category)"
        cell.addressLabel.text = item.address
        cell.phoneNumberLabel.text = "📞\(item.phoneNumber)"
        cell.priceLabel.text = "₩ \(item.price.formatted())"
        
        cell.likeButton.setImage(heartImage, for: .normal)
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        return cell
    }
}
