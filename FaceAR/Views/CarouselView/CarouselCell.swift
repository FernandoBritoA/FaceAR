//
//  CarouselCell.swift
//  FaceAR
//
//  Created by Fernando Brito on 27/09/23.
//

import UIKit

class CarouselCell: UICollectionViewCell {
    static var identifier: String = "CarouselCell"

    let imageView: UIImageView = {
        let image = UIImageView()

        image.backgroundColor = .white

        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(imageView)
        imageView.frame = contentView.bounds
        imageView.layer.cornerRadius = contentView.frame.width / 2
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CarouselCell {
    public func configure(with imageName: String) {
        imageView.image = UIImage(named: imageName)
    }
}
