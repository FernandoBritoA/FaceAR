//
//  CarouselView.swift
//  FaceAR
//
//  Created by Fernando Brito on 27/09/23.
//

import UIKit

class CarouselView: UIView {
    var viewModel = CarouselViewModel()

    var carousel: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = CarouselK.itemSpacing
        layout.itemSize = CGSize(width: CarouselK.itemSize, height: CarouselK.itemSize)

        let horizontalInset = CarouselK.horizontalInset
        layout.sectionInset = UIEdgeInsets(top: 0, left: horizontalInset, bottom: 0, right: horizontalInset)

        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false

        return collectionView
    }()

    override func layoutSubviews() {
        super.layoutSubviews()

        self.setupCarousel()
        self.setupSelectedItemLayer()
    }

    private func setupCarousel() {
        self.addSubview(self.carousel)
        self.carousel.frame = bounds

        self.carousel.register(CarouselCell.self, forCellWithReuseIdentifier: CarouselCell.identifier)

        self.carousel.delegate = self
        self.carousel.dataSource = self
    }

    private func setupSelectedItemLayer() {
        let size = CarouselK.itemSize * 1.2
        let positionOffset = size / 2

        let xPosition = (frame.width / 2.0) - positionOffset
        let yPosition = (frame.height / 2.0) - positionOffset

        let circleLayer = CALayer()

        circleLayer.borderWidth = 4
        circleLayer.cornerRadius = size / 2
        circleLayer.borderColor = UIColor.systemCyan.cgColor
        circleLayer.frame = CGRect(x: xPosition, y: yPosition, width: size, height: size)

        self.layer.insertSublayer(circleLayer, at: 0)
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
