//
//  VideoViewController.swift
//  FaceAR
//
//  Created by Fernando Brito on 26/09/23.
//

import ARKit
import UIKit

class VideoViewController: UIViewController {
    var recorder = RecorderViewModel()

    let sceneView = ARSCNView()
    let carouselView = CarouselView()
    let recordButton = RecordButton(size: 70.0)

    let recordingQueue = DispatchQueue(label: "recordingThread", attributes: .concurrent)

    override func viewDidLoad() {
        super.viewDidLoad()

        recorder.configure(with: sceneView)

        view.addSubview(sceneView)
        view.addSubview(carouselView)
        view.addSubview(recordButton)

        sceneView.delegate = self
        carouselView.delegete = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard ARFaceTrackingConfiguration.isSupported else { return }

        let configuration = ARFaceTrackingConfiguration()

        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])

        recorder.prepare(with: configuration)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        sceneView.session.pause()

        recorder.forceStop()
    }
}
