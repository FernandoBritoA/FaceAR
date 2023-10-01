//
//  CarouselViewDelegate.swift
//  FaceAR
//
//  Created by Fernando Brito on 30/09/23.
//

import Foundation

protocol CarouselViewDelegate: AnyObject {
    func carouselView(_ carouselView: CarouselView, didSelectItemAt index: Int)
}
