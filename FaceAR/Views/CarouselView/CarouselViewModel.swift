//
//  CarouselViewModel.swift
//  FaceAR
//
//  Created by Fernando Brito on 27/09/23.
//

import Foundation

struct CarouselViewModel {
    public var currentIndex: Int = 0
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

    public mutating func updateIndex(newValue: Int) {
        currentIndex = newValue
    }

    public func calculateIndex(position: CGFloat, snapToPosition: (Int) -> Void) {
        let index: CGFloat = position / CarouselK.itemSize

        // Determine the delta (change) from current index
        let delta: CGFloat = index - CGFloat(currentIndex)

        /*
         Determine where to snap to
         If the absolute value of the delta is larger than 0.25 consider a movement valid.
         */
        if abs(delta) > 0.25 {
            let minIndex = 0
            let maxIndex = renderList.count - 1
            var targetIndex = delta > 0 ? Int(ceil(index)) : Int(floor(index))

            if targetIndex < minIndex {
                targetIndex = minIndex
            } else if targetIndex > maxIndex {
                targetIndex = maxIndex
            }

            snapToPosition(targetIndex)
        } else {
            snapToPosition(currentIndex)
        }
    }
}
