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
        
        return chattingCell
    }
}

extension ChattingViewController: UISearchBarDelegate {    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        
        if text.isEmpty {
            initializeData()
        } else {
            filteredChatRoomList  = mockChatList.filter { $0.chatroomName.contains(text) }
            searchBar.text = ""
        }
        chattingTableView.reloadData()
    }
}
