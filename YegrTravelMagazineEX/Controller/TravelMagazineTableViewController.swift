//
//  TravelMagazineTableViewController.swift
//  YegrTravelMagazineEX
//
//  Created by YJ on 5/25/24.
//

import UIKit

class TravelMagazineTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 500
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MagazineInfo.shared.magazine.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TravelMagazineTableViewCell.identifier, for: indexPath) as? TravelMagazineTableViewCell else { return UITableViewCell() }
        
        let magazineInfo = MagazineInfo.shared.magazine[indexPath.row]
        if let url = URL(string: magazineInfo.photo_image) {
            cell.setPosterImage(imageURL: url)
        }
        cell.posterImageView.layer.cornerRadius = 10
        cell.posterImageView.contentMode = .scaleAspectFill

        return cell
    }
}
