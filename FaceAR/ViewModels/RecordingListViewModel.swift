//
//  RecordingListViewModel.swift
//  FaceAR
//
//  Created by Fernando Brito on 02/10/23.
//

import Photos
import UIKit

class RecordingListViewModel {
    public weak var delegate: UITableView?

    public var videos: [PHAsset] = []
    private var localIdentifiers: [String] = []

    public func getInitialData() {
        fetchVideos()
    }

    private func fetchVideos() {
        PHAsset.fetchVideos(withLocalIdentifiers: localIdentifiers) { [weak self] assets in
            self?.videos = assets
            print(assets.count)

            DispatchQueue.main.async {
                self?.delegate?.reloadData()
            }
        }
    }

    public func addNew(identifier: String) {
        localIdentifiers.append(identifier)

        fetchVideos()
    }
}

// TableView related methods
extension RecordingListViewModel {
    public func getNumberOfRows() -> Int {
        return videos.count
    }

    public func getVideo(by indexPath: IndexPath) -> PHAsset {
        return videos[indexPath.row]
    }
}
