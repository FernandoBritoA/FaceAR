//
//  VideoViewController.swift
//  FaceAR
//
//  Created by Fernando Brito on 26/09/23.
//

import ARKit
import SCNRecorder
import UIKit

class VideoViewController: UIViewController {
    let sceneView = ARSCNView()
    let carouselView = CarouselView()
    let recordButton = RecordButton(size: 70.0)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(sceneView)
        view.addSubview(carouselView)
        view.addSubview(recordButton)

        sceneView.delegate = self
        carouselView.delegete = self
        recordButton.delegete = self

        sceneView.prepareForRecording()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard ARFaceTrackingConfiguration.isSupported else { return }

        let configuration = ARFaceTrackingConfiguration()

        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        sceneView.session.pause()
    }
}
