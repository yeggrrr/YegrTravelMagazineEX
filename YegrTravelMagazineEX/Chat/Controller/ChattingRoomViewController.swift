//
//  ChattingRoomViewController.swift
//  YegrTravelMagazineEX
//
//  Created by YJ on 6/2/24.
//

import UIKit

class ChattingRoomViewController: UIViewController {
    @IBOutlet var chatRoomTableView: UITableView!
    @IBOutlet var keyboardView: UIView!
    @IBOutlet var inputTextView: UITextView!
    @IBOutlet var sendButton: UIButton!
    
    var chatData: ChatRoom?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationUI()
        textFeildUI()
        configureTableView()
        // setupKeyboardEvent() -> 아직 제대로 작동 안함
    }

    func textFeildUI() {
        keyboardView.layer.borderWidth = 2
        keyboardView.layer.borderColor = UIColor(named: "TextFieldBackgroundColor")?.cgColor
        
        inputTextView.backgroundColor = UIColor(named: "TextFieldBackgroundColor")
        inputTextView.tintColor = .systemGray
        inputTextView.textColor = .white
    
        sendButton.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        sendButton.tintColor = UIColor(named: "ButtonColor")
    }
    
    func configureTableView() {
        chatRoomTableView.delegate = self
        chatRoomTableView.dataSource = self
        
        chatRoomTableView.separatorStyle = .none
        chatRoomTableView.keyboardDismissMode = .onDrag
        
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

   //  //observer등록
   //  func setupKeyboardEvent() {
   //      NotificationCenter.default.addObserver(self, selector: #selector(textViewMoveUp), name: UIResponder.keyboardWillShowNotification, object: nil)
   //              
   //      NotificationCenter.default.addObserver(self, selector: #selector(textViewMoveDown), name: UIResponder.keyboardWillHideNotification, object: nil)
   //  }
   //  
   //  @objc func textViewMoveUp(_ notification: NSNotification){
   //         
   //     if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
   //         UIView.animate(withDuration: 0.3, animations: {
   //             self.chatRoomTableView.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height)
   //         })
   //     }
   // }
   //     
   // @objc func textViewMoveDown(_ notification: NSNotification){
   //         self.chatRoomTableView.transform = .identity
   // }

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
            if let partnerChatData = chatData?.chatList[indexPath.row] {
                partnerCell.configureCell(chatData: partnerChatData)
                return partnerCell
            }
        } else {
            guard let userCell = tableView.dequeueReusableCell(withIdentifier: ChatUserTableViewCell.identifier, for: indexPath) as? ChatUserTableViewCell else { return UITableViewCell() }
            if let userChatData = chatData?.chatList[indexPath.row] {
                userCell.configureCell(chatData: userChatData)
                return userCell
            }
        }
        return UITableViewCell()
    }
}

extension ChattingRoomViewController: UITextViewDelegate {
    
}
