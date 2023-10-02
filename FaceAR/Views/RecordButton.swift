//
//  RecordButton.swift
//  FaceAR
//
//  Created by Fernando Brito on 26/09/23.
//

import UIKit

enum RecordState {
    case active
    case inactive
}

protocol RecordButtonDelegate: AnyObject {
    func recordButton(_ recordButton: RecordButton, didChangeState state: RecordState)
}

class RecordButton: UIButton {
    public weak var delegete: RecordButtonDelegate?

    private var size: Double = 0.0

    init(size: Double) {
        super.init(frame: CGRect(x: 0, y: 0, width: size, height: size))

        self.size = size

        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPress(gesture:)))

        layer.cornerRadius = size / 2
        addGestureRecognizer(longPressGesture)

        updateButtonUI(to: .inactive)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension RecordButton {
    private func updateButtonUI(to state: RecordState) {
        var image: UIImage?
        let config = UIImage.SymbolConfiguration(pointSize: size, weight: .regular)

        switch state {
        case .active:
            tintColor = .systemRed

            UIView.animate(withDuration: 0.5) {
                self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }

            image = UIImage(systemName: "record.circle.fill", withConfiguration: config)

        case .inactive:
            tintColor = .white

            UIView.animate(withDuration: 0.5) {
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
            }

            image = UIImage(systemName: "record.circle", withConfiguration: config)
        }

        setImage(image, for: .normal)
    }

    @objc private func longPress(gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            updateButtonUI(to: .active)
            delegete?.recordButton(self, didChangeState: .active)

        case .ended:
            updateButtonUI(to: .inactive)
            delegete?.recordButton(self, didChangeState: .inactive)

        default:
            break
        }
    }
}
