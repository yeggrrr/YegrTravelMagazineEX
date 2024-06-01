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
        configureTableView()
    }

    func navigationUI() {
        navigationItem.title = "YEGR TALK"
    }
    
    func configureTableView() {
        chattingTableView.delegate = self
        chattingTableView.dataSource = self
        let chatXib = UINib(nibName: ChattingTableViewCell.identifier, bundle: nil)
        chattingTableView.register(chatXib, forCellReuseIdentifier: ChattingTableViewCell.identifier)
    }
}

extension ChattingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return User.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let chattingCell = tableView.dequeueReusableCell(withIdentifier: ChattingTableViewCell.identifier, for: indexPath) as? ChattingTableViewCell else { return UITableViewCell() }
        
        chattingCell.configureCell()
        
        return chattingCell
    }
}
