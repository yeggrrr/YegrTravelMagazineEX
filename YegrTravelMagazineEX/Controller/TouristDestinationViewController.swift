//
//  TouristDestinationViewController.swift
//  YegrTravelMagazineEX
//
//  Created by YJ on 5/29/24.
//

import UIKit

class TouristDestinationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationUI()
    }
    
    func navigationUI() {
        navigationItem.title = "관광지 화면"
        let left = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(xBarButtonClicked))
        navigationItem.leftBarButtonItem = left
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "ButtonColor")
    }
    
    @objc func xBarButtonClicked() {
        navigationController?.popViewController(animated: true)
    }

}
