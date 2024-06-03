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
        // setupKeyboardEvent() //-> 아직 제대로 작동 안함
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
        
        let partnerXib = UINib(nibName: ChatPartnerTableViewCell.id, bundle: nil)
        chatRoomTableView.register(partnerXib, forCellReuseIdentifier: ChatPartnerTableViewCell.id)
        
        let userXib = UINib(nibName: ChatUserTableViewCell.id, bundle: nil)
        chatRoomTableView.register(userXib, forCellReuseIdentifier: ChatUserTableViewCell.id)
        
        let dateXib = UINib(nibName: DateSeparatorTableViewCell.id, bundle: nil)
        chatRoomTableView.register(dateXib, forCellReuseIdentifier: DateSeparatorTableViewCell.id)
    }
    
    func navigationUI() {
        guard let chatRoomName = chatData?.chatroomName else { return }
        navigationItem.title = chatRoomName
        
        let left = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(xBarButtonClicked))
        navigationItem.leftBarButtonItem = left
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "ButtonColor")
    }

    //observer등록
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
   //             self.keyboardView.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 84)
   //         })
   //     }
   // }
   //  
   //  @objc func textViewMoveDown(_ notification: NSNotification){
   //      self.chatRoomTableView.transform = .identity
   //      self.keyboardView.transform = .identity
   //  }

    @objc func xBarButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
}

extension ChattingRoomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let chatData = chatData else { return 0 }
        return chatData.chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let chatData = chatData else { return UITableViewCell() }
        let chatList = chatData.chatList
        let item = chatList[indexPath.row]
        let notLastIndex = indexPath.row != chatList.count - 1
        
        if notLastIndex {
            let targetDateString = item.date
            let nextDateString = chatList[indexPath.row + 1].date
            let targetDate = DateFormatter.longToShortDate(dateString: targetDateString)
            let nextDate = DateFormatter.longToShortDate(dateString: nextDateString)
            
            if targetDate != nextDate {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: DateSeparatorTableViewCell.id, for: indexPath) as? DateSeparatorTableViewCell else { return UITableViewCell() }
                cell.configureCell(chatData: item)
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                return cell
            }
        }
        
        switch chatList[indexPath.row].user {
        case .user:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatUserTableViewCell.id, for: indexPath) as? ChatUserTableViewCell else { return UITableViewCell() }
            cell.configureCell(chatData: item)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatPartnerTableViewCell.id, for: indexPath) as? ChatPartnerTableViewCell else { return UITableViewCell() }
            cell.configureCell(chatData: item)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }
    }
}
