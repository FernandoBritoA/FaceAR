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
        PHPhotoLibrary.shared().saveVideo(with: session) { result in
            switch result {
            case .success(let savedSession):
                print(savedSession)
                // TODO: Store this session

            case .failure:
                self.showToast(message: "Could not save video.", type: .error)
            }
        }
    }
}
