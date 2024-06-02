//
//  ChattingRoomViewController.swift
//  YegrTravelMagazineEX
//
//  Created by YJ on 6/2/24.
//

import UIKit

class ChattingRoomViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationUI()
    }
    
    func navigationUI() {
        navigationItem.title = "partner 이름"
        let left = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(xBarButtonClicked))
        navigationItem.leftBarButtonItem = left
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "ButtonColor")
    }
    
    @objc func xBarButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
}
