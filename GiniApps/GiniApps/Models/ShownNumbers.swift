//
//  ShownNumbers.swift
//  GiniApps
//
//  Created by niv ben-porath on 29/06/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation

//enum HeightForCell : Int {
//    case zeroSum = 100
//    case nonZeroSum = 50
//}

enum ShownNumberType {
    case zeroSumNumber(height : Int)
}

struct ShownNumber {
    var number : Int
    var height : Int
}
