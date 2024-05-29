//
//  CityViewController.swift
//  YegrTravelMagazineEX
//
//  Created by YJ on 5/29/24.
//

import UIKit

class CityViewController: UIViewController {
    @IBOutlet var citySegmentedControl: UISegmentedControl!
    @IBOutlet var cityTableView: UITableView!
    
    let data = CityInfo.city
    var filteredDataList: [City] = []
    var isFiltered = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setSegmentControll()
    }
    
    func configureUI() {
        // navigation title
        navigationItem.title = "인기 도시"
        
        // tableview
        cityTableView.delegate = self
        cityTableView.dataSource = self
        
        let cityXib = UINib(nibName: CityTableViewCell.identifier, bundle: nil)
        cityTableView.register(cityXib, forCellReuseIdentifier: CityTableViewCell.identifier)
    }
    
    func setSegmentControll() {
        citySegmentedControl.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
    }
    
    @objc func segmentValueChanged(segment: UISegmentedControl) {
        isFiltered = true
        
        switch segment.selectedSegmentIndex {
        case 0:
            filteredDataList = CityInfo.city
            print("0클릭됨")
        case 1:
            filteredDataList = CityInfo.city.filter{ $0.domestic_travel == true }
            print("1클릭됨")
        case 2:
            filteredDataList = CityInfo.city.filter{ $0.domestic_travel == false }
            print("2클릭됨")
        default:
            break
        }
        
        cityTableView.reloadData()
    }
}

extension CityViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltered {
            return filteredDataList.count
        } else {
            return data.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as? CityTableViewCell else { return UITableViewCell() }
        let data = isFiltered ? filteredDataList[indexPath.row] : data[indexPath.row]
        cell.configureCell(data: data)
        return cell
    }
}
