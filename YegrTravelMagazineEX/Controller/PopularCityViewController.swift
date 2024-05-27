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
        130
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        travelData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularCityTableViewCell.identifier, for: indexPath) as? PopularCityTableViewCell else { return UITableViewCell() }
        
        let data = TravelInfo.shared.travel[indexPath.row]
        cell.configureCell(data: data)
    
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        return cell
    }
    
    @objc func likeButtonClicked(sender: UIButton) {
        TravelInfo.shared.travel[sender.tag].like?.toggle()
        popularCityTableView.reloadData()
    }
}
