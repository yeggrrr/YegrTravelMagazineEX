//
//  RestaurantTableViewController.swift
//  YegrTravelMagazineEX
//
//  Created by YJ on 5/25/24.
//

import UIKit
import Kingfisher
import MarqueeLabel

class RestaurantTableViewController: UITableViewController {
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    
    var searchList: [Restaurant] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        initailzedData()
    }
    
    func configureUI() {
        // Navigation title
        title = "Restaurant"
        let left = UIBarButtonItem(image: UIImage(systemName: "map"), style: .plain, target: self, action: #selector(mapButtonClicked))
        navigationItem.leftBarButtonItem = left
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "ButtonColor")
        
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
        searchList = RestaurantList.restaurantArray
    }
    
    func getSearchData() {
        guard let text = searchTextField.text else { return }
        
        if text.isEmpty {
            initailzedData()
        } else {
            searchList = RestaurantList.restaurantArray.filter{ $0.category == text || $0.name.contains(text) }
            searchTextField.text = ""
            
            if searchList.isEmpty {
                let alert = UIAlertController(title: "🔔알림🔔", message: "검색 결과가 없어요! \n가게 이름이나 한식, 중식, 일식, 카페 등 \n카테고리를 입력해주세요.", preferredStyle: .alert)
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
    
    @objc func mapButtonClicked() {
        let sb = UIStoryboard(name: "RestaurantMap", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "RestaurantMapViewController") as! RestaurantMapViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func likeButtonClicked(sender: UIButton) {
        searchList[sender.tag].like.toggle()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
        for i in 0..<RestaurantList.restaurantArray.count {
            let item = RestaurantList.restaurantArray[i]
            if item.name == searchList[sender.tag].name {
                RestaurantList.restaurantArray[i].like = searchList[sender.tag].like
                return
            }
        }
    }
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        getSearchData()
    }
}

extension RestaurantTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantTableViewCell.identifier, for: indexPath) as? RestaurantTableViewCell else { return UITableViewCell() }
        
        let item = searchList[indexPath.row]
        let heartImage = item.like ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        
        cell.configure()
        cell.configureCell(item: item)
        cell.likeButton.setImage(heartImage, for: .normal)
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        return cell
    }
}
