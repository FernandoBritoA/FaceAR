//
//  VideoViewController+ARSCNViewDelegate.swift
//  FaceAR
//
//  Created by Fernando Brito on 29/09/23.
//

import ARKit
import UIKit

extension VideoViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard let sceneView = renderer as? ARSCNView,
              let faceAnchor = anchor as? ARFaceAnchor
        else {
            return nil
        }

        #if targetEnvironment(simulator)
        #error("ARKit is not supported in iOS Simulator. Connect a physical iOS device and select it as your Xcode run destination.")
        #else
        let faceGeometry = ARSCNFaceGeometry(device: sceneView.device!)

        let node = SCNNode(geometry: faceGeometry)
        node.geometry?.firstMaterial?.transparency = 0.0

        let moustacheNode = MoustacheSCNNode(with: faceAnchor)

        node.addChildNode(moustacheNode)

        #endif
        return node
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let faceAnchor = anchor as? ARFaceAnchor,
              let faceGeometry = node.geometry as? ARSCNFaceGeometry
        else {
            return
        }

        faceGeometry.update(from: faceAnchor.geometry)
    }

    func session(_ session: ARSession, didFailWithError error: Error) {
        delegate?.videoViewController(didFailWithError: error)
        navigationController?.popViewController(animated: true)
    }
}
