//
//  CarouselView+ScrollView.swift
//  FaceAR
//
//  Created by Fernando Brito on 27/09/23.
//

import UIKit

extension CarouselView {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            let position: CGFloat = self.carousel.contentOffset.x

            viewModel.calculateIndex(position: position, snapToPosition: self.snapToPositon)
        }
    }

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        let position: CGFloat = self.carousel.contentOffset.x

        viewModel.calculateIndex(position: position, snapToPosition: self.snapToPositon)
    }

    func snapToPositon(index: Int) {
        viewModel.updateIndex(newValue: index)
        delegete?.carouselView(self, didSelectItemAt: index)

        self.carousel.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: true)
    }
}
