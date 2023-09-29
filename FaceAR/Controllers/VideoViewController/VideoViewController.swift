//
//  VideoViewController.swift
//  FaceAR
//
//  Created by Fernando Brito on 26/09/23.
//

import ARKit
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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let configuration = ARFaceTrackingConfiguration()

        sceneView.session.run(configuration)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        sceneView.session.pause()
    }
}
