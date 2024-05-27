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
        let popularCityCellXib = UINib(nibName: PopularCityTableViewCell.identifier, bundle: nil)
        popularCityTableView.register(popularCityCellXib, forCellReuseIdentifier: PopularCityTableViewCell.identifier)
        
        let adCellXib = UINib(nibName: AdTableViewCell.identifier, bundle: nil)
        popularCityTableView.register(adCellXib, forCellReuseIdentifier: AdTableViewCell.identifier)
        
    }
}

extension PopularCityViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if TravelInfo.shared.travel[indexPath.row].ad == true {
            return 90
        } else {
            return 150
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        travelData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = TravelInfo.shared.travel[indexPath.row]
        let color = ["Blue", "Pink", "Green", "Purple", "Yellow"]
        let randomColor = color.randomElement()!
        
        if data.ad == true {
            guard let adTableViewCell = tableView.dequeueReusableCell(withIdentifier: AdTableViewCell.identifier, for: indexPath) as? AdTableViewCell else { return UITableViewCell() }
            adTableViewCell.adLabel.text = data.title
            adTableViewCell.backgoundColorView.backgroundColor = UIColor(named: randomColor)
            return adTableViewCell
        } else {
            guard let popularCityTableViewCell = tableView.dequeueReusableCell(withIdentifier: PopularCityTableViewCell.identifier, for: indexPath) as? PopularCityTableViewCell else { return UITableViewCell() }
            popularCityTableViewCell.configureCell(data: data)
            popularCityTableViewCell.likeButton.tag = indexPath.row
            popularCityTableViewCell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
            return popularCityTableViewCell
        }
    }
    
    @objc func likeButtonClicked(sender: UIButton) {
        TravelInfo.shared.travel[sender.tag].like?.toggle()
        popularCityTableView.reloadData()
    }
}
