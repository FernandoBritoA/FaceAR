//
//  RecordingListCell.swift
//  FaceAR
//
//  Created by Fernando Brito on 03/10/23.
//

import Photos
import UIKit

class RecordingListCell: UITableViewCell {
    let imageWidthProportion = 0.56
    static var identifier = "RecordingListCell"

    override func layoutSubviews() {
        super.layoutSubviews()

        customizeUI()
    }

    public func configure(with video: PlayableVideo) {
        textLabel?.text = video.tag
        detailTextLabel?.text = formatToTime(duration: video.duration)

        requestImage(for: video.videoAsset)
    }

    private func requestImage(for asset: PHAsset) {
        // Placeholder
        imageView?.image = UIImage(named: "emptyPortrait")
        imageView?.contentMode = .scaleAspectFill

        let frameHeight = contentView.frame.height
        let size = CGSize(width: frameHeight * imageWidthProportion, height: frameHeight)

        PHCachingImageManager.default().requestImage(
            for: asset,
            targetSize: size,
            contentMode: .aspectFit,
            options: nil)
        { [weak self] photo, _ in

            if let photo {
                self?.imageView?.image = photo
            }
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
                imageView.widthAnchor.constraint(equalToConstant: contentView.frame.height * imageWidthProportion),
            ])
        }
    }
}
