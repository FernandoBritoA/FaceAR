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
        if totalSeconds < 60 {
            return "\(totalSeconds) s"
        }

        let minutes = Int(totalSeconds) / 60
        let seconds = Int(totalSeconds) % 60

        return "\(minutes):\(seconds)"
    }
}
