//
//  RecordingListViewViewController.swift
//  FaceAR
//
//  Created by Fernando Brito on 02/10/23.
//

import Photos
import UIKit

class RecordingListViewViewController: UITableViewController {
    var viewModel = RecordingListViewModel()
    
    let tableViewCellIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Recordings"
        viewModel.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: tableViewCellIdentifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.getInitialData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier)!
            
        let videoAsset = viewModel.getVideo(by: indexPath)

        cell.textLabel?.text = "\(videoAsset.duration) seconds"
        PHCachingImageManager.default().requestImage(
            for: videoAsset,
            targetSize: CGSize(width: 100, height: 100),
            contentMode: .aspectFill,
            options: nil)
        { photo, _ in
                
            cell.imageView?.image = photo
        }
            
        return cell
    }
}
