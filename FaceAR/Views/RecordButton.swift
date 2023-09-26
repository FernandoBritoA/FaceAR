//
//  RecordButton.swift
//  FaceAR
//
//  Created by Fernando Brito on 26/09/23.
//

import UIKit

class RecordButton: UIButton {
    private var isRecording: Bool = false

    init(size: Double) {
        super.init(frame: CGRect(x: 0, y: 0, width: size, height: size))

        let largeConfig = UIImage.SymbolConfiguration(pointSize: size, weight: .regular)
        let inactiveImage = UIImage(systemName: "record.circle", withConfiguration: largeConfig)
        let activeImage = UIImage(systemName: "record.circle.fill", withConfiguration: largeConfig)

        tintColor = .white
        layer.cornerRadius = size / 2
        setImage(inactiveImage, for: .normal)
        setImage(activeImage, for: .highlighted)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
