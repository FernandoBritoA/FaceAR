//
//  VideoViewController+UI.swift
//  FaceAR
//
//  Created by Fernando Brito on 29/09/23.
//

import UIKit

extension VideoViewController {
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        setupConstraints()
        sceneView.frame = view.bounds
    }

    private func setupConstraints() {
        carouselView.translatesAutoresizingMaskIntoConstraints = false
        let carouselViewConstraints = [
            carouselView.heightAnchor.constraint(equalToConstant: 100),
            carouselView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            carouselView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            carouselView.bottomAnchor.constraint(equalTo: recordButton.topAnchor),
        ]

        recordButton.translatesAutoresizingMaskIntoConstraints = false
        let recordButtonConstraints = [
            recordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recordButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -10),
        ]

        NSLayoutConstraint.activate(carouselViewConstraints + recordButtonConstraints)
    }
}
