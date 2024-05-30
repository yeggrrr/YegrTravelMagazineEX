//
//  AdvertisementViewController.swift
//  YegrTravelMagazineEX
//
//  Created by YJ on 5/29/24.
//

import UIKit

class AdvertisementViewController: UIViewController {

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
        
    }
    
    @objc func xBarButtonClicked() {
        dismiss(animated: true)
    }
}
