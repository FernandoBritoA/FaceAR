//
//  RecordingListViewController+TableView.swift
//  FaceAR
//
//  Created by Fernando Brito on 02/10/23.
//
import AVKit
import Photos
import UIKit

extension RecordingListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = RecordingListCell(style: .subtitle, reuseIdentifier: RecordingListCell.identifier)
        
        let video = viewModel.getVideo(by: indexPath)
        
        cell.configure(with: video)
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let video = viewModel.getVideo(by: indexPath)
        
        PHCachingImageManager.default().requestAVAsset(forVideo: video.videoAsset, options: nil) { [weak self] video, _, _ in
            if let video = video {
                DispatchQueue.main.async {
                    self?.playVideo(video)
                }
            }
        }
    }
    
    private func playVideo(_ video: AVAsset) {
        let playerItem = AVPlayerItem(asset: video)
        let player = AVPlayer(playerItem: playerItem)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
            
        present(playerViewController, animated: true) {
            if let validPlayer = playerViewController.player {
                validPlayer.play()
            }
        }
    }
}
