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

    public func getInitialData(onError: @escaping (Error) -> Void) {
        DataPersistenceManager.shared.fetchingRecordingsFromDataBase { [weak self] result in
            switch result {
            case .success(let recordingSessions):
                let identifiers = recordingSessions.map { session in
                    session.id!
                }
                self?.fetchVideos(with: identifiers)
            case .failure(let error):
                onError(error)
            }
        }
    }

    private func fetchVideos(with identifiers: [String]) {
        PHAsset.fetchVideos(with: identifiers) { [weak self] assets in
            self?.videos += assets

            DispatchQueue.main.async {
                self?.delegate?.reloadData()
            }
        }
    }

    public func addNew(identifier: String) {
        fetchVideos(with: [identifier])
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
