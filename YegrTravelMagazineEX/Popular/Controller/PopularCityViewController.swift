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
    
    let travelData = TravelInfo.travel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "도시 상세 정보"
        tableViewConfigure()
    }
    
    func tableViewConfigure() {
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
        if TravelInfo.travel[indexPath.row].ad == true {
            return 90
        } else {
            return 150
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        travelData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = TravelInfo.travel[indexPath.row]
        
        if data.ad == true {
            guard let adTableViewCell = tableView.dequeueReusableCell(withIdentifier: AdTableViewCell.identifier, for: indexPath) as? AdTableViewCell else { return UITableViewCell() }
            adTableViewCell.configureCell(data: data)
            return adTableViewCell
        } else {
            guard let popularCityTableViewCell = tableView.dequeueReusableCell(withIdentifier: PopularCityTableViewCell.identifier, for: indexPath) as? PopularCityTableViewCell else { return UITableViewCell() }
            popularCityTableViewCell.configureCell(data: data)
            popularCityTableViewCell.likeButton.tag = indexPath.row
            popularCityTableViewCell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
            return popularCityTableViewCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = TravelInfo.travel[indexPath.row]
        
        if data.ad == true{
            let sb = UIStoryboard(name: "Advertisement", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "AdvertisementViewController") as! AdvertisementViewController
            vc.AdDetailData = data
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            navigationController?.present(nav, animated: true)
        } else {
            let sb = UIStoryboard(name: "TouristDestination", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "TouristDestinationViewController") as! TouristDestinationViewController
            vc.touristDetailData = data
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func likeButtonClicked(sender: UIButton) {
        TravelInfo.travel[sender.tag].like?.toggle()
        popularCityTableView.reloadData()
    }
}
