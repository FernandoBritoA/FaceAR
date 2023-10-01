//
//  VideoViewController+CarouselViewDelegate.swift
//  FaceAR
//
//  Created by Fernando Brito on 30/09/23.
//

import Foundation

extension VideoViewController: CarouselViewDelegate {
    func carouselView(_ carouselView: CarouselView, didSelectItemAt index: Int) {
        print(index)
    }
}
