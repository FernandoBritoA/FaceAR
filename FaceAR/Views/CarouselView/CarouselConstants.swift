//
//  CarouselConstants.swift
//  FaceAR
//
//  Created by Fernando Brito on 27/09/23.
//

import Foundation

let maxElementsVisible: Double = 5.0
let availableSpace: CGFloat = DimensionsK.screenWidth - (DimensionsK.horizontalSpacing * 2)

enum CarouselK {
    static let itemSpacing: CGFloat = 20.0
    static let itemSize: CGFloat = (availableSpace - (itemSpacing * (maxElementsVisible - 1))) / maxElementsVisible
    static let horizontalInset = (itemSize + itemSpacing) * 2
}
