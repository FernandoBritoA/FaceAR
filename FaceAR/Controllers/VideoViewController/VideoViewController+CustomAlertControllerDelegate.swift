//
//  VideoViewController+CustomAlertControllerDelegate.swift
//  FaceAR
//
//  Created by Fernando Brito on 03/10/23.
//

import Photos
import SCNRecorder
import UIKit

extension VideoViewController: CustomAlertControllerDelegate {
    func customAlertController(didChangeShowingState isShowing: Bool) {
        if isShowing {
            pauseARSession()
        } else {
            runARSession()
        }
    }

    func customAlertController(didSelectSave session: TempRecordingSession) {
        PHPhotoLibrary.shared().saveVideo(with: session) { [weak self] result in
            switch result {
            case .success(let savedSession):
                DispatchQueue.main.async {
                    DataPersistenceManager.shared.saveSessionData(with: savedSession) { result in
                        switch result {
                        case .success():
                            self?.showToast(message: "Video saved!", type: .informative)
                        case .failure(let error):
                            self?.showToast(message: "Could not save video, \(error.localizedDescription)", type: .error)
                        }
                    }
                }

            case .failure:
                self?.showToast(message: "Could not save video.", type: .error)
            }
        }
    }
}
