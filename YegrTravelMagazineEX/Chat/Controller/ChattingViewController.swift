//
//  ChattingViewController.swift
//  YegrTravelMagazineEX
//
//  Created by YJ on 6/1/24.
//

import UIKit

class ChattingViewController: UIViewController {
    @IBOutlet var chattingSearchBar: UISearchBar!
    @IBOutlet var chattingTableView: UITableView!
    
    var filteredChatRoomList: [ChatRoom] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeData()
        navigationUI()
        searchBarUI()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = chattingTableView.indexPathForSelectedRow {
            chattingTableView.deselectRow(at: selectedIndexPath, animated: animated)
        }
    }
    
    func initializeData() {
        filteredChatRoomList = mockChatList
    }
    
    func navigationUI() {
        navigationItem.title = "YEGR TALK"
    }
    
    func searchBarUI() {
        chattingSearchBar.delegate = self
        
        chattingSearchBar.placeholder = "친구 이름을 검색해보세요"
        chattingSearchBar.tintColor = .darkGray
        chattingSearchBar.keyboardType = .default
        chattingSearchBar.returnKeyType = .default
        
        // cancelButton Color
        let cancelButtonAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "ButtonColor")]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes as [NSAttributedString.Key : Any] , for: .normal)
        // searchBarTextField Color
        if let textfield = chattingSearchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = UIColor(named: "TextFieldBackgroundColor")
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
            textfield.textColor = UIColor.white
            // 왼쪽 아이콘 이미지
            if let leftView = textfield.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = UIColor.white
            }
        }
    }
    
    func configureTableView() {
        chattingTableView.delegate = self
        chattingTableView.dataSource = self
        
        let chatXib = UINib(nibName: ChattingTableViewCell.identifier, bundle: nil)
        chattingTableView.register(chatXib, forCellReuseIdentifier: ChattingTableViewCell.identifier)
        
        chattingTableView.keyboardDismissMode = .onDrag
    }
}

extension ChattingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredChatRoomList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let chattingCell = tableView.dequeueReusableCell(withIdentifier: ChattingTableViewCell.identifier, for: indexPath) as? ChattingTableViewCell else { return UITableViewCell() }
        
        let index = indexPath.row
        chattingCell.configureCell(index: index, mockChatList: filteredChatRoomList)
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(named: "TextFieldBackgroundColor")
        chattingCell.selectedBackgroundView = bgColorView
        
        return chattingCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatData = filteredChatRoomList[indexPath.row]
        
        let sb = UIStoryboard(name: "Chatting", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ChattingRoomViewController") as! ChattingRoomViewController
        vc.chatData = chatData
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ChattingViewController: UISearchBarDelegate {    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text?.lowercased() else { return }
        
        if text.isEmpty {
            initializeData()
        } else {
            filteredChatRoomList  = mockChatList.filter { $0.chatroomName.lowercased().contains(text) }
            searchBar.text = ""
            
            if filteredChatRoomList.isEmpty {
                let alert = UIAlertController(title: "🔔알림🔔", message: "검색하신 채팅방이 없어요!", preferredStyle: .alert)
                let checkButton = UIAlertAction(title: "확인", style: .default)
                alert.addAction(checkButton)
                present(alert, animated: true)
                initializeData()
                searchBar.text = ""
            }
        }
        chattingTableView.reloadData()
    }
}
