//
//  RecordingListCell.swift
//  FaceAR
//
//  Created by Fernando Brito on 03/10/23.
//

import Photos
import UIKit

class RecordingListCell: UITableViewCell {
    static var identifier = "RecordingListCell"

    override func layoutSubviews() {
        super.layoutSubviews()

        customizeUI()
    }

    public func configure(with asset: PHAsset) {
        textLabel?.text = asset.originalFilename
        detailTextLabel?.text = formatToTime(duration: asset.duration)

        requestImage(for: asset)
    }

    private func requestImage(for asset: PHAsset) {
        let size = CGSize(width: 100, height: contentView.frame.height)

        PHCachingImageManager.default().requestImage(
            for: asset,
            targetSize: size,
            contentMode: .aspectFit,
            options: nil)
        { [weak self] photo, _ in

            self?.imageView?.image = photo
        }
    }

    private func formatToTime(duration totalSeconds: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad

        return formatter.string(from: totalSeconds)!
    }

    private func customizeUI() {
        if let textLabel {
            textLabel.numberOfLines = 2
            textLabel.font = UIFont.systemFont(ofSize: 20)
        }

        if let imageView {
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 8
            imageView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                imageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            ])
        }
    }
}
