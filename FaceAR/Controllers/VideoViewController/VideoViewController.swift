//
//  VideoViewController.swift
//  FaceAR
//
//  Created by Fernando Brito on 26/09/23.
//

import ARKit
import SCNRecorder
import UIKit

protocol VideoViewControllerDelegate: UIViewController {
    func videoViewController(didFailWithError error: Error)
}

class VideoViewController: UIViewController {
    weak var delegate: VideoViewControllerDelegate?

    let sceneView = ARSCNView()
    var captureSession: AVCaptureSession?
    let carouselView = CarouselView()
    let recordButton = RecordButton(size: 70.0)
    let alertController = CustomAlertController()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(sceneView)
        view.addSubview(carouselView)
        view.addSubview(recordButton)

        sceneView.delegate = self
        carouselView.delegete = self
        recordButton.delegete = self
        alertController.delegate = self

        sceneView.prepareForRecording()
        captureSession = try? .makeAudioForRecorder(sceneView.recorder!)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        runARSession()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        pauseARSession()
    }

    internal func runARSession() {
        guard ARFaceTrackingConfiguration.isSupported else { return }

        let configuration = ARFaceTrackingConfiguration()
        configuration.providesAudioData = true

        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }

    internal func pauseARSession() {
        sceneView.session.pause()
    }
}
