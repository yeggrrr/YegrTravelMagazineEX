//
//  CityViewController.swift
//  YegrTravelMagazineEX
//
//  Created by YJ on 5/29/24.
//

import UIKit

enum FilterType: Int {
    case all = 0
    case domestic
    case international
}

class CityViewController: UIViewController {
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var citySegmentedControl: UISegmentedControl!
    @IBOutlet var cityTableView: UITableView!
    @IBOutlet var noticeLabel: UILabel!
    
    let cityList = CityInfo.city
    var filteredDataList: [City] = []
    var isFiltered = false
    var filterType: FilterType = .all
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setSegmentControll()
        setSearchBar()
    }
    
    func configureUI() {
        // navigation title
        navigationItem.title = "인기 도시"
        
        // tableview
        cityTableView.delegate = self
        cityTableView.dataSource = self
        
        let cityXib = UINib(nibName: CityTableViewCell.identifier, bundle: nil)
        cityTableView.register(cityXib, forCellReuseIdentifier: CityTableViewCell.identifier)
        
        // noticeLabel
        noticeLabel.isHidden = true
        noticeLabel.textColor = .darkGray
        noticeLabel.font = .boldSystemFont(ofSize: 20)
        noticeLabel.textAlignment = .center
        
        cityTableView.keyboardDismissMode = .onDrag
    }
    
    func setSegmentControll() {
        citySegmentedControl.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
    }
    
    func setSearchBar() {
        searchBar.placeholder = "입력해주세요."
        searchBar.tintColor = .darkGray
        // cancelButton Color
        let cancelButtonAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "ButtonColor")]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes as [NSAttributedString.Key : Any] , for: .normal)
        // searchBarTextField Color
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = UIColor(named: "TextFieldBackgroundColor")
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
            textfield.textColor = UIColor.white
            // 왼쪽 아이콘 이미지
            if let leftView = textfield.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = UIColor.white
            }
        }
    }
    
    func updateCityList() {
        switch filterType {
        case .all:
            filteredDataList = cityList
        case .domestic:
            filteredDataList = cityList.filter{ $0.domestic_travel }
        case .international:
            filteredDataList = cityList.filter{ !$0.domestic_travel }
        }
        noticeLabel.isHidden = true
        cityTableView.reloadData()
    }
    
    @objc func segmentValueChanged(segment: UISegmentedControl) {
        isFiltered = true
        
        switch segment.selectedSegmentIndex {
        case 0:
            filterType = .all
        case 1:
            filterType = .domestic
        case 2:
            filterType = .international
        default:
            break
        }
        updateCityList()
    }
}

extension CityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltered ? filteredDataList.count : cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as? CityTableViewCell else { return UITableViewCell() }
        let data = isFiltered ? filteredDataList[indexPath.row] : cityList[indexPath.row]
        cell.configureCell(data: data)
        return cell
    }
}

extension CityViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isFiltered = true
        guard let searchText = searchBar.text?.lowercased() else { return }
        let matchedNameList = CityInfo.city.filter{ $0.city_name.lowercased().contains(searchText) }
        let matchedEnglishNameList = CityInfo.city.filter{ $0.city_english_name.lowercased().contains(searchText) }
        let matchedExplainList = CityInfo.city.filter{ $0.city_explain.lowercased().contains(searchText) }
        
        let searchedList = matchedNameList + matchedEnglishNameList + matchedExplainList
        let result = Array(Set(searchedList))
        
        switch filterType {
        case .all:
            filteredDataList = result
            noticeLabel.isHidden = true
        case .domestic:
            filteredDataList = result.filter{ $0.domestic_travel }
            noticeLabel.isHidden = true
        case .international:
            filteredDataList = result.filter{ !$0.domestic_travel }
            noticeLabel.isHidden = true
        }
        
        if searchText == "" {
            filteredDataList = cityList
            citySegmentedControl.selectedSegmentIndex = 0
            
            let alert = UIAlertController(title: "검색어를 입력해주세요!", message: nil, preferredStyle: .alert)
            let okButton = UIAlertAction(title: "확인", style: .default)
            alert.addAction(okButton)
            present(alert, animated: true)
        } else if filteredDataList.isEmpty {
            noticeLabel.isHidden = false
            noticeLabel.text = "검색 결과 없음"
            searchBar.text = ""
        }
    
        cityTableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}
