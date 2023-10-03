//
//  RecordingListViewController+TableView.swift
//  FaceAR
//
//  Created by Fernando Brito on 02/10/23.
//

import Photos
import UIKit

extension RecordingListViewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = RecordingListCell(style: .subtitle, reuseIdentifier: RecordingListCell.identifier)
        
        let videoAsset = viewModel.getVideo(by: indexPath)
        
        cell.configure(with: videoAsset)
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
