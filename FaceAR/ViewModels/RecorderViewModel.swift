//
//  RecorderViewModel.swift
//  FaceAR
//
//  Created by Fernando Brito on 02/10/23.
//

import ARKit
import ARVideoKit
import Foundation

struct RecorderViewModel {
    var recorder: RecordAR?

    let recordingQueue = DispatchQueue(label: "recordingThread", attributes: .concurrent)

    mutating func configure(with scene: ARSCNView) {
        recorder = RecordAR(ARSceneKit: scene)

        recorder?.contentMode = .aspectFill
        recorder?.onlyRenderWhileRecording = false
        recorder?.inputViewOrientations = [.portrait]
    }

    func prepare(with configuration: ARConfiguration) {
        recorder?.prepare(configuration)
    }

    func start() {
        if recorder?.status != .readyToRecord {
            return
        }

        recordingQueue.async {
            self.recorder?.record()
        }
    }

    func stop() {
        if recorder?.status != .recording {
            return
        }

        recorder?.stop { path in
            print(path)
        }
    }

    func forceStop() {
        if recorder?.status == .recording {
            recorder?.stop()
        }
        recorder?.onlyRenderWhileRecording = true
        recorder?.prepare(ARWorldTrackingConfiguration())

        // Switch off the orientation lock for UIViewControllers with AR Scenes
        recorder?.rest()
    }
}
