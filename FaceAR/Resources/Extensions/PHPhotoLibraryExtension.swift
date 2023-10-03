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
        with url: URL,
        fileName: String,
        completion: @escaping (Result<String, any Error>) -> Void)
    {
        var localIdentifier = ""

        func save() {
            PHPhotoLibrary.shared().performChanges({
                let options = PHAssetResourceCreationOptions()
                options.originalFilename = fileName

                let request = PHAssetCreationRequest.forAsset()
                request.addResource(with: .video, fileURL: url, options: options)

                let placeHolder = request.placeholderForCreatedAsset
                localIdentifier = placeHolder?.localIdentifier ?? ""
            }) { saved, error in

                if error != nil {
                    completion(.failure(SaveError.assetCreation))
                } else if saved {
                    completion(.success(localIdentifier))
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

            let fetchResults = PHAsset.fetchAssets(withLocalIdentifiers: identifiers, options: nil)

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
}
