//
//  UIViewControllerExtension.swift
//  FaceAR
//
//  Created by Fernando Brito on 02/10/23.
//

import UIKit

enum ToastType {
    case informative
    case error
}

extension UIViewController {
    func showToast(message: String, type: ToastType) {
        let padding = 5.0
        let verticalOffset = 120.0
        let horizontalOffset = 20.0
        let bgColor: UIColor = type == .informative ? .black : .systemRed

        let containerView = UIView(frame: CGRect(
            x: horizontalOffset,
            y: verticalOffset,
            width: self.view.frame.width - horizontalOffset * 2,
            height: 40 + padding * 2))

        let toastLabel = UILabel(frame: CGRect(
            x: padding,
            y: padding,
            width: containerView.frame.width - padding * 2,
            height: containerView.frame.height - padding * 2))

        containerView.alpha = 1.0
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 8
        containerView.backgroundColor = bgColor.withAlphaComponent(0.9)

        toastLabel.text = message
        toastLabel.numberOfLines = 2
        toastLabel.textAlignment = .center
        toastLabel.textColor = UIColor.white
        toastLabel.font = .systemFont(ofSize: 12)

        containerView.addSubview(toastLabel)
        self.view.addSubview(containerView)

        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            containerView.alpha = 0.0
        }, completion: { _ in
            containerView.removeFromSuperview()
        })
    }
}
