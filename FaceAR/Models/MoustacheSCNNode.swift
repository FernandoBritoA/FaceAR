//
//  MoustacheSCNNode.swift
//  FaceAR
//
//  Created by Fernando Brito on 29/09/23.
//

import ARKit
import SceneKit

class MoustacheSCNNode: SCNNode {
    static let uniqueName: String = "moustache"

    init(with anchor: ARFaceAnchor) {
        super.init()

        // Node Name
        name = MoustacheSCNNode.uniqueName

        // Node Geometry Image
        let plane = SCNPlane(width: 0.1, height: 0.1)
        plane.firstMaterial?.diffuse.contents = UIImage(named: "moustache0")
        plane.firstMaterial?.isDoubleSided = true

        geometry = plane

        // Node Position
        let moustacheVerticeIndex = 0
        let vertice = anchor.geometry.vertices[moustacheVerticeIndex]

        position = SCNVector3(vertice)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MoustacheSCNNode {
    func updateImage(index: Int) {
        if let plane = geometry as? SCNPlane {
            plane.firstMaterial?.diffuse.contents = UIImage(named: "moustache\(index)")
            plane.firstMaterial?.isDoubleSided = true
        }
    }
}
