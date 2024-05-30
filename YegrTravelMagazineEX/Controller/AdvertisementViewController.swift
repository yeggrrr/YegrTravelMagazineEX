//
//  AdvertisementViewController.swift
//  YegrTravelMagazineEX
//
//  Created by YJ on 5/29/24.
//

import UIKit

class AdvertisementViewController: UIViewController {
    @IBOutlet var adTitleLabel: UILabel!
    @IBOutlet var adImageView: UIImageView!
    @IBOutlet var adDescriptionLabel: UILabel!
    
    var AdDetailData: Travel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationUI()
        configureUI()
    }
    
    func navigationUI() {
        navigationItem.title = "광고 화면"
        let left = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(xBarButtonClicked))
        navigationItem.leftBarButtonItem = left
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "ButtonColor")
    }
    
    func configureUI() {
        // adTitleLabel
        adTitleLabel.text = AdDetailData?.title
        adTitleLabel.textColor = .darkGray
        adTitleLabel.textAlignment = .center
        adTitleLabel.font = .boldSystemFont(ofSize: 22)
        adTitleLabel.numberOfLines = 0
        
        // adImageView
        adImageView.image = UIImage(named: "SeSAC")
        adImageView.contentMode = .scaleAspectFit
        adImageView.layer.cornerRadius = 10
        
        // adDescriptionLabel
        adDescriptionLabel.text = "Welcome to SeSAC~^^"
        adDescriptionLabel.textAlignment = .center
        adDescriptionLabel.textColor = .systemGreen
        adDescriptionLabel.font = .boldSystemFont(ofSize: 25)
        adDescriptionLabel.numberOfLines = 0
    }
    
    @objc func xBarButtonClicked() {
        dismiss(animated: true)
    }
}
