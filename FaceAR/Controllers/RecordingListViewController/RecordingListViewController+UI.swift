//
//  RecordingListViewController+UI.swift
//  FaceAR
//
//  Created by Fernando Brito on 02/10/23.
//

import UIKit

extension RecordingListViewViewController {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        setupConstraints()
        tableView.frame = view.bounds
        tableView.separatorStyle = .none
    }

    private func setupConstraints() {
        button.translatesAutoresizingMaskIntoConstraints = false
        let buttonConstraints = [
            button.heightAnchor.constraint(equalToConstant: 70),
            button.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]

        NSLayoutConstraint.activate(buttonConstraints)
    }
}
