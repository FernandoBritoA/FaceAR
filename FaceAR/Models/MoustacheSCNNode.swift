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
    private var defaultYPosition: Float = 0.0

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
        let moustacheVerticeIndex = 1

        let vertice = anchor.geometry.vertices[moustacheVerticeIndex]

        position = SCNVector3(vertice)
        defaultYPosition = vertice.y
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MoustacheSCNNode {
    func updateImage(index: Int) {
        guard let plane = geometry as? SCNPlane else {
            return
        }

        plane.firstMaterial?.diffuse.contents = UIImage(named: "moustache\(index)")
        plane.firstMaterial?.isDoubleSided = true

        switch index {
        case 2:
            scale(to: 1.5)
            translateY(offset: -0.026)
        case 4:
            scale(to: 0.8)
            translateY(offset: 0.003)
        case 5:
            scale(to: 0.9)
            translateY(offset: 0.012)
        case 6:
            scale(to: 1.5)
            translateY(offset: -0.012)
        case 7:
            scale(to: 1.5)
            translateY(offset: 0)
        default:
            scale(to: 1.0)
            translateY(offset: 0)
        }
    }

    private func scale(to value: Float) {
        scale = SCNVector3(x: value, y: value, z: 1.0)
    }

    private func translateY(offset: Float) {
        position = SCNVector3(position.x, defaultYPosition + offset, position.z)
    }
}
