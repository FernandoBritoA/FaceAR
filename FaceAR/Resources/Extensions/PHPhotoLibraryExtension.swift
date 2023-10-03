//
//  PHPhotoLibraryExtension.swift
//  FaceAR
//
//  Created by Fernando Brito on 02/10/23.
//

import Foundation
import Photos

enum SaveError: Error {
    case assetCreation
}

extension PHPhotoLibrary {
    func saveVideo(
        with recordingSession: TempRecordingSession,
        completion: @escaping (Result<SavedRecordingSession, any Error>) -> Void)
    {
        func save() {
            var localIdentifier = ""

            PHPhotoLibrary.shared().performChanges({
                let options = PHAssetResourceCreationOptions()
                options.originalFilename = recordingSession.tag

                let request = PHAssetCreationRequest.forAsset()
                request.addResource(with: .video, fileURL: recordingSession.info.url, options: options)

                let placeHolder = request.placeholderForCreatedAsset
                localIdentifier = placeHolder?.localIdentifier ?? ""

            }) { saved, error in

                if error != nil {
                    completion(.failure(SaveError.assetCreation))
                } else if saved {
                    let recordSession = SavedRecordingSession(
                        id: localIdentifier,
                        tag: recordingSession.tag,
                        duration: recordingSession.info.duration)

                    completion(.success(recordSession))
                }
            }
        }

        PHPhotoLibrary.shared().handleAuthorization { status in
            switch status {
                case .authorized:
                    save()
                // TODO: Handle other status cases
                default:
                    break
            }
        }
    }

    func handleAuthorization(completion: @escaping (PHAuthorizationStatus) -> Void) {
        if PHPhotoLibrary.authorizationStatus(for: .readWrite) == .authorized {
            completion(.authorized)
        } else {
            PHPhotoLibrary.requestAuthorization { status in
                completion(status)
            }
        }
    }
}

extension PHAsset {
    static func fetchVideos(
        withLocalIdentifiers identifiers: [String],
        completion: @escaping ([PHAsset]) -> Void)
    {
        func fetch() {
            var assets: [PHAsset] = []

            let options = PHFetchOptions()
            options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

            let fetchResults = PHAsset.fetchAssets(withLocalIdentifiers: identifiers, options: options)

            fetchResults.enumerateObjects { asset, _, _ in
                assets.append(asset)
            }

            completion(assets)
        }

        PHPhotoLibrary.shared().handleAuthorization { status in
            switch status {
                case .authorized:
                    fetch()
                // TODO: Handle other status cases
                default:
                    break
            }
        }
    }

    var originalFilename: String? {
        var fileName: String?

        if #available(iOS 9.0, *) {
            let resources = PHAssetResource.assetResources(for: self)
            if let resource = resources.first {
                fileName = resource.originalFilename
            }
        }

        if fileName == nil {
            fileName = self.value(forKey: "filename") as? String
        }

        return fileName
    }
}
