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

        if PHPhotoLibrary.authorizationStatus(for: .readWrite) == .authorized {
            save()
        } else {
            PHPhotoLibrary.requestAuthorization { status in
                if status == .authorized {
                    save()
                }
            }
        }
    }
}
