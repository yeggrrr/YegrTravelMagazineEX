//
//  ChattingRoomViewController.swift
//  YegrTravelMagazineEX
//
//  Created by YJ on 6/2/24.
//

import UIKit

class ChattingRoomViewController: UIViewController {

    var chatData: ChatRoom?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationUI()
    }
    
    func navigationUI() {
        guard let chatRoomName = chatData?.chatroomName else { return }
        navigationItem.title = chatRoomName
        
        let left = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(xBarButtonClicked))
        navigationItem.leftBarButtonItem = left
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "ButtonColor")
    }
    
    @objc func xBarButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
}
