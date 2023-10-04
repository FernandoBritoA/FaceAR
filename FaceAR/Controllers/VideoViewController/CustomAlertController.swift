//
//  CustomAlertController.swift
//  FaceAR
//
//  Created by Fernando Brito on 03/10/23.
//

import SCNRecorder
import UIKit

protocol CustomAlertControllerDelegate: UIViewController {
    func customAlertController(didChangeShowingState isShowing: Bool)
    func customAlertController(didSelectSave recordingSession: TempRecordingSession)
}

class CustomAlertController {
    weak var delegate: CustomAlertControllerDelegate?

    public func show(with recordingInfo: VideoRecording.Info) {
        let alertVC = UIAlertController(title: "New Recording", message: "Add a tag name to this recording", preferredStyle: .alert)

        /*
            NOTE: Adding this textField to the alert introduces a log noise in the console than can be safely ignored.
            More info: https://stackoverflow.com/a/75246980
         */
        alertVC.addTextField { textField in
            textField.placeholder = "Tag"
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { [weak self] _ in
            self?.delegate?.customAlertController(didChangeShowingState: false)
        }

        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in

            let tagName = alertVC.textFields![0].text ?? "Tag"
            alertVC.textFields![0].text = ""

            let session = TempRecordingSession(tag: tagName, info: recordingInfo)

            self?.delegate?.customAlertController(didSelectSave: session)
            self?.delegate?.customAlertController(didChangeShowingState: false)
        }

        alertVC.addAction(cancelAction)
        alertVC.addAction(saveAction)

        delegate?.present(alertVC, animated: true)
        delegate?.customAlertController(didChangeShowingState: true)
    }
}
