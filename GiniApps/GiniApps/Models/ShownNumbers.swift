//
//  ShownNumbers.swift
//  GiniApps
//
//  Created by niv ben-porath on 29/06/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation

enum ShownNumberTypeHeight : Int {
    case sumEqualZero = 100
    case sumNotEqualZero = 50
}

struct ShownNumberType {
    var shownNumberTypeHeight : ShownNumberTypeHeight
}

struct ShownNumber {
    var number : Int
    var height : ShownNumberType
}
