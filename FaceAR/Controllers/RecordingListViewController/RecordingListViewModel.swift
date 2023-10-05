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

    public var videos: [PlayableVideo] = []

    public func getInitialData(onError: @escaping (Error) -> Void) {
        DataPersistenceManager.shared.fetchingRecordingsFromDataBase { [weak self] result in
            switch result {
            case .success(let recordingSessions):

                self?.fetchVideoAssets(for: recordingSessions)
            case .failure(let error):
                onError(error)
            }
        }
    }

    private func fetchVideoAssets(for recordingSessions: [RecordingSession]) {
        guard recordingSessions.count > 0 else {
            return
        }

        let identifiers: [String] = recordingSessions.map { session in
            session.id ?? ""
        }

        PHAsset.fetchVideos(with: identifiers) { [weak self] assets in
            guard let videoList = self?.videos, recordingSessions.count == assets.count else {
                return
            }

            var newVideos: [PlayableVideo] = []

            let lastIndex = recordingSessions.getLastIndex()
            Array(0 ... lastIndex).forEach { index in

                let currentAsset = assets[index]
                let currentSession = recordingSessions[index]

                let playableVideo = PlayableVideo(
                    id: currentSession.id!,
                    tag: currentSession.tag!,
                    duration: currentSession.duration,
                    videoAsset: currentAsset)

                newVideos.insert(playableVideo, at: 0)
            }

            self?.videos = newVideos + videoList

            DispatchQueue.main.async {
                self?.delegate?.reloadData()
            }
        }
    }

    public func addNew(session: RecordingSession) {
        fetchVideoAssets(for: [session])
    }
}

// TableView related methods
extension RecordingListViewModel {
    public func getNumberOfRows() -> Int {
        return videos.count
    }

    public func getVideo(by indexPath: IndexPath) -> PlayableVideo {
        return videos[indexPath.row]
    }
}
