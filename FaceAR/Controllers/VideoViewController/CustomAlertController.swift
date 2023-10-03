//
//  CustomAlertController.swift
//  FaceAR
//
//  Created by Fernando Brito on 03/10/23.
//

import SCNRecorder
import UIKit

protocol CustomAlertControllerDelegate: AnyObject {
    func customAlertController(didSelectSave recordingSession: TempRecordingSession)
    func customAlertController(didHideController: Bool)
}

class CustomAlertController {
    weak var delegate: CustomAlertControllerDelegate?

    let alert = UIAlertController(title: "New Recording", message: "Add a tag name to this recording", preferredStyle: .alert)

    var recordingInfo: VideoRecording.Info?

    init() {
        alert.addTextField { textField in
            textField.placeholder = "Tag"
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { [weak self] _ in
            self?.delegate?.customAlertController(didHideController: true)
        }

        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in

            guard let recordingInfo = self?.recordingInfo else {
                self?.delegate?.customAlertController(didHideController: true)

                return
            }

            let tagName = self?.alert.textFields![0].text ?? "Tag"

            let session = TempRecordingSession(tag: tagName, info: recordingInfo)

            self?.alert.textFields![0].text = ""

            self?.delegate?.customAlertController(didSelectSave: session)
            self?.delegate?.customAlertController(didHideController: true)
        }

        alert.addAction(cancelAction)
        alert.addAction(saveAction)
    }

    func addRecordingInfo(_ info: VideoRecording.Info) {
        recordingInfo = info
    }
}
