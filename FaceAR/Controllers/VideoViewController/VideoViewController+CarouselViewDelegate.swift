//
//  VideoViewController+CarouselViewDelegate.swift
//  FaceAR
//
//  Created by Fernando Brito on 30/09/23.
//

import ARKit
import Foundation

extension VideoViewController: CarouselViewDelegate {
    func carouselView(_ carouselView: CarouselView, didSelectItemAt index: Int) {
        let nodes = sceneView.scene.rootNode.childNodes

        for node in nodes {
            if let moustacheNode = node.childNode(withName: MoustacheSCNNode.uniqueName, recursively: false) as? MoustacheSCNNode {
                moustacheNode.updateImage(index: index)
            }
        }
    }
}
