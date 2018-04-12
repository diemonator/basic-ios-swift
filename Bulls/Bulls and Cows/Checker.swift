//
//  Checker.swift
//  Bulls and Cows
//
//  Created by Emil Karamihov on 10/04/2018.
//  Copyright © 2018 Emil Karamihov. All rights reserved.
//

import UIKit

class Checker: NSObject {
    static func checkInput(number: String, name: String) -> Bool {
        if (number.count == 4 && name.count > 0) {
            var check = Array(number)
            for i in 0...number.count-1 {
                for j in 0...check.count-1 {
                    if (i != j) {
                        if (check[i] == check[j]) {
                            return false
                        }
                    }
                }
            }
        } else {
            return false
        }
        return true
    }
    
    static func checkInput(number: String) -> Bool {
        if (number.count == 4) {
            var check = Array(number)
            for i in 0...number.count-1 {
                for j in 0...check.count-1 {
                    if (i != j) {
                        if (check[i] == check[j]) {
                            return false
                        }
                    }
                }
            }
        } else {
            return false
        }
        return true
    }
}
