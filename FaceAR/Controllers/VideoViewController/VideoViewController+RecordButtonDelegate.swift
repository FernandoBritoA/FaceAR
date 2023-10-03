//
//  VideoViewController+RecordButtonDelegate.swift
//  FaceAR
//
//  Created by Fernando Brito on 02/10/23.
//

import SCNRecorder
import UIKit

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
            onStartRecording()
            
        case .inactive:
            onStopRecording()
        }
    }
    
    private func onStartRecording() {
        carouselView.isHidden = true
        navigationController?.isNavigationBarHidden = true
        
        do {
            try sceneView.startVideoRecording()
        } catch {
            showToast(message: "Could not start recording.", type: .error)
        }
    }
    
    private func onStopRecording() {
        carouselView.isHidden = false
        navigationController?.isNavigationBarHidden = false
        
        sceneView.finishVideoRecording { [weak self] recording in
           
            self?.showAlertController(with: recording)
        }
    }
}
