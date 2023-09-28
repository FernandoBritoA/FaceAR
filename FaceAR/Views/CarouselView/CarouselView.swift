//
//  CarouselView.swift
//  FaceAR
//
//  Created by Fernando Brito on 27/09/23.
//

import UIKit

class CarouselView: UIView {
    private let viewModel = CarouselViewModel()

    private var carousel: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 50.0
        layout.itemSize = CGSize(width: 50, height: 50)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false

        return collectionView
    }()

    override func layoutSubviews() {
        super.layoutSubviews()

        self.setupCarousel()
    }

    private func setupCarousel() {
        self.addSubview(self.carousel)
        self.carousel.frame = bounds

        self.carousel.register(CarouselCell.self, forCellWithReuseIdentifier: CarouselCell.identifier)

        self.carousel.delegate = self
        self.carousel.dataSource = self
    }
}

extension CarouselView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel.getNumberOfItems()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCell.identifier, for: indexPath) as? CarouselCell else {
            return UICollectionViewCell()
        }

        cell.configure(with: self.viewModel.getElement(by: indexPath))

        return cell
    }
}
