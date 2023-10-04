//
//  RecordingListViewController.swift
//  FaceAR
//
//  Created by Fernando Brito on 02/10/23.
//

import UIKit

class RecordingListViewController: UIViewController {
    var viewModel = RecordingListViewModel()
    
    let tableView = UITableView()
    
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
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupTableView()
        
        view.addSubview(tableView)
        view.addSubview(button)
        
        viewModel.getInitialData { [weak self] error in
            self?.showToast(message: "Couldn't load videos data. Error: \(error.localizedDescription)", type: .error)
        }
        
        button.addAction(UIAction(handler: { [weak self] _ in
            let vc = VideoViewController()
            
            self?.navigationController?.pushViewController(vc, animated: true)
        }), for: .touchUpInside)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel.delegate = tableView
    }
}
