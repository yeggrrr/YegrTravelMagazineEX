//
//  ChattingRoomViewController.swift
//  YegrTravelMagazineEX
//
//  Created by YJ on 6/2/24.
//

import UIKit

class ChattingRoomViewController: UIViewController {

    @IBOutlet var chatRoomTableView: UITableView!
    
    var chatData: ChatRoom?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationUI()
        configureTableView()
    }
    
    func configureTableView() {
        chatRoomTableView.delegate = self
        chatRoomTableView.dataSource = self
        
        let partnerXib = UINib(nibName: ChatPartnerTableViewCell.identifier, bundle: nil)
        chatRoomTableView.register(partnerXib, forCellReuseIdentifier: ChatPartnerTableViewCell.identifier)
        
        let userXib = UINib(nibName: ChatUserTableViewCell.identifier, bundle: nil)
        chatRoomTableView.register(userXib, forCellReuseIdentifier: ChatUserTableViewCell.identifier)
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

extension ChattingRoomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let chatCount = chatData?.chatList.count ?? 0
        return chatCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if chatData?.chatList[indexPath.row].user != User.user {
            guard let partnerCell = tableView.dequeueReusableCell(withIdentifier: ChatPartnerTableViewCell.identifier, for: indexPath) as? ChatPartnerTableViewCell else { return UITableViewCell() }
            return partnerCell
        } else {
            guard let userCell = tableView.dequeueReusableCell(withIdentifier: ChatUserTableViewCell.identifier, for: indexPath) as? ChatUserTableViewCell else { return UITableViewCell() }
            return userCell
        }
    }
    
    
}
