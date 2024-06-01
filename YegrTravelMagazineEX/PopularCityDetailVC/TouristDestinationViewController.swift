//
//  TouristDestinationViewController.swift
//  YegrTravelMagazineEX
//
//  Created by YJ on 5/29/24.
//

import UIKit
import Kingfisher

class TouristDestinationViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var gradeSaveLabel: UILabel!
    
    var touristDetailData: Travel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationUI()
        configureUI()
    }
    
    func navigationUI() {
        navigationItem.title = "관광지 화면"
        let left = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(xBarButtonClicked))
        navigationItem.leftBarButtonItem = left
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "ButtonColor")
    }
    
    func configureUI() {
        // titleLabel
        titleLabel.text = touristDetailData?.title
        titleLabel.textColor = .darkGray
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 21)
        
        // posterImageView
        guard let image = touristDetailData?.travel_image else { return }
        let url = URL(string: image)
        posterImageView.kf.setImage(with: url)
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.cornerRadius = 10
        
        // descriptionLabel
        descriptionLabel.text = touristDetailData?.description
        descriptionLabel.textColor = .darkGray
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = .boldSystemFont(ofSize: 19)
        descriptionLabel.numberOfLines = 0
        
        // gradeSaveLabel
        guard let grade = touristDetailData?.grade else { return }
        guard let save = touristDetailData?.save else { return }
        gradeSaveLabel.text = "평점: \(grade)점 | 공감: \(save)명"
        gradeSaveLabel.textColor = .systemCyan
        gradeSaveLabel.textAlignment = .center
        gradeSaveLabel.font = .boldSystemFont(ofSize: 15)
        descriptionLabel.numberOfLines = 0
    }
    
    @objc func xBarButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
}
