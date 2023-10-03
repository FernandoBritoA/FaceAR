//
//  RecordingListViewController+TableView.swift
//  FaceAR
//
//  Created by Fernando Brito on 02/10/23.
//

import Photos
import UIKit

extension RecordingListViewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
    
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
