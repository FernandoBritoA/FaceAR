//
//  RecordingListViewController+VideoViewControllerDelegate.swift
//  FaceAR
//
//  Created by Fernando Brito on 04/10/23.
//

import Foundation

extension RecordingListViewController: VideoViewControllerDelegate {
    func videoViewController(didFailWithError error: Error) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.showToast(message: error.localizedDescription, type: .error)
        }
    }
}
