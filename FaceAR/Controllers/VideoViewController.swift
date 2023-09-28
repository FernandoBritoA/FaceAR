//
//  VideoViewController.swift
//  FaceAR
//
//  Created by Fernando Brito on 26/09/23.
//

import UIKit

class VideoViewController: UIViewController {
    private let carouselView = CarouselView()
    private let recordButton = RecordButton(size: 70.0)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(carouselView)
        view.addSubview(recordButton)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        setupConstraints()
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
