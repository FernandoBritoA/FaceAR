//
//  RecordSession.swift
//  FaceAR
//
//  Created by Fernando Brito on 03/10/23.
//

import Foundation
import Photos
import SCNRecorder

struct TempRecordingSession {
    let tag: String
    let info: VideoRecording.Info
}

struct SavedRecordingSession {
    let id: String
    let tag: String
    let duration: TimeInterval
}

struct PlayableVideo {
    let id: String
    let tag: String
    let duration: TimeInterval
    let videoAsset: PHAsset
}
