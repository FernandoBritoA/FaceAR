//
//  VideoViewController+RecordButtonDelegate.swift
//  FaceAR
//
//  Created by Fernando Brito on 02/10/23.
//

import Foundation

extension VideoViewController: RecordButtonDelegate {
    func recordButton(_ recordButton: RecordButton, didInvalidGesture isInvalid: Bool) {
        if isInvalid {
            let errorMessage = "Keep the button pressed to start recording."

            showToast(message: errorMessage, type: .informative)
        }
    }

    func recordButton(_ recordButton: RecordButton, didChangeState state: RecordState) {
        switch state {
            case .active:
                recorder.start()

            case .inactive:
                recorder.stop()
        }
    }
}
