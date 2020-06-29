//
//  ShownNumbersViewModel.swift
//  GiniApps
//
//  Created by niv ben-porath on 29/06/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit

final class ShownNumbersViewModel {
    private var shownNumbers = [ShownNumber]()
    private let urlString = "https://pastebin.com/raw/8wJzytQX"
    
    var numberOfItems : Int {
        shownNumbers.count
    }
    
    func number(at row : Int) -> String {
        String(shownNumbers[row].number)
    }
    
    func height(at row : Int) -> CGFloat {
        CGFloat(integerLiteral: shownNumbers[row].height)
    }
}

extension ShownNumbersViewModel {
    
    func requestArray(with completion : @escaping (Error?) -> Void) {
        let dataFetching = DataFetching()
        guard let url = URL(string: urlString) else{
            preconditionFailure("error in url")
        }
        
        dataFetching.requestArray(at: url) {[weak self] (result) in
            guard let self = self else {return}
            switch result {
            case.success(let allNumbers):
                self.checkForZeroSum(on: allNumbers.numbers)
                DispatchQueue.main.async {
                    completion(nil)
                }
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    private func checkForZeroSum(on array : [Number]) {
//        var zeroSumNumbers = [Int]()
        print(array.count)
        shownNumbers.append(ShownNumber(number: array[0].number,height: 50))//setup the first element in the shown array

        for i in 0..<array.count {
            for j in i+1..<array.count {
                if i == 0 {
                    //we setup the shown numbers only on the first pass. we init all of them with
                    shownNumbers.append(ShownNumber(number: array[j].number,height: 50))
                }
                if array[i].number + array[j].number == 0 {
                    print("\(i) and \(j)" )
                    shownNumbers.remove(at: i)
                    shownNumbers.insert(ShownNumber(number: array[i].number,height: 100), at: i)
                    shownNumbers.remove(at: j)
                     shownNumbers.insert(ShownNumber(number: array[j].number,height: 100), at: j)
//                    zeroSumNumbers.append(i)
//                    zeroSumNumbers.append(j)
                }
            }
        }
        print(shownNumbers.count)
    }
}
