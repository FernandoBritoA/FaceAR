//
//  VideoViewController+RecordButtonDelegate.swift
//  FaceAR
//
//  Created by Fernando Brito on 02/10/23.
//

import Foundation

extension VideoViewController: RecordButtonDelegate {
    func recordButton(_ recordButton: RecordButton, didChangeState state: RecordState) {
        switch state {
            case .active:
                recorder.start()
            case .inactive:
                recorder.stop()
        }
    }
}
