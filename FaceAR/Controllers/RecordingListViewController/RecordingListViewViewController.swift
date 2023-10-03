//
//  RecordingListViewViewController.swift
//  FaceAR
//
//  Created by Fernando Brito on 02/10/23.
//

import UIKit

class RecordingListViewViewController: UIViewController {
    var viewModel = RecordingListViewModel()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.estimatedRowHeight = 60.0
        tableView.separatorStyle = .singleLine
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    
    let button: UIButton = {
        let btn = UIButton()
        
        var config = UIButton.Configuration.filled()
        
        config.title = "New Recording"
        config.cornerStyle = .large
        config.baseBackgroundColor = .systemBlue
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        btn.configuration = config
        
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "My Recordings"
        
        setupTableView()
        
        view.addSubview(tableView)
        view.addSubview(button)
        
        viewModel.getInitialData()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel.delegate = tableView
    }
}
