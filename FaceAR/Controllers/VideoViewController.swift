//
//  VideoViewController.swift
//  FaceAR
//
//  Created by Fernando Brito on 26/09/23.
//

import UIKit

class VideoViewController: UIViewController {
    let recordButton = RecordButton(size: 70.0)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(recordButton)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        setupConstraints()
    }

    func setupConstraints() {
        recordButton.translatesAutoresizingMaskIntoConstraints = false
        let recordButtonConstraints = [
            recordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recordButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -10)
        ]

        NSLayoutConstraint.activate(recordButtonConstraints)
    }
}
