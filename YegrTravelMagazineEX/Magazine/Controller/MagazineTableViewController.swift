//
//  MagazineTableViewController.swift
//  YegrTravelMagazineEX
//
//  Created by YJ on 5/25/24.
//

import UIKit
import Kingfisher

class MagazineTableViewController: UITableViewController {
    
    let data = MagazineInfo.magazine
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 540
        navigationItem.title = "Magazine"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MagazineTableViewCell.id, for: indexPath) as?
                MagazineTableViewCell else { return UITableViewCell() }
        let data = MagazineInfo.magazine[indexPath.row]
        cell.configureUI()
        cell.configureCell(data: data)
        return cell
    }
}
