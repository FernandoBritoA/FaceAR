//
//  CarouselViewModel.swift
//  FaceAR
//
//  Created by Fernando Brito on 27/09/23.
//

import Foundation

struct CarouselViewModel {
    public var renderList: [String] = []

    init() {
        let maxIndex = 7
        let indexesArr = 0 ... maxIndex

        renderList = indexesArr.map { i in
            "moustache\(i)"
        }
    }

    public func getNumberOfItems() -> Int {
        return renderList.count
    }

    public func getElement(by indexPath: IndexPath) -> String {
        return renderList[indexPath.row]
    }
}
