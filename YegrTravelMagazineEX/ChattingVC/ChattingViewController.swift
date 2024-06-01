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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationUI()
        searchBarUI()
        configureTableView()
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
        return mockChatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let chattingCell = tableView.dequeueReusableCell(withIdentifier: ChattingTableViewCell.identifier, for: indexPath) as? ChattingTableViewCell else { return UITableViewCell() }
        
        let index = indexPath.row
        chattingCell.configureCell(index: index)
        
        return chattingCell
    }
}

extension ChattingViewController: UISearchBarDelegate {
    
}
