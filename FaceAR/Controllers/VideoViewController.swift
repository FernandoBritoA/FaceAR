//
//  VideoViewController.swift
//  FaceAR
//
//  Created by Fernando Brito on 26/09/23.
//

import UIKit

class VideoViewController: UIViewController {
    let recordButton: UIButton = {
        let button = UIButton()

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(recordButton)
    }
}
