//
//  Player.swift
//  Bulls and Cows
//
//  Created by Emil Karamihov on 05/04/2018.
//  Copyright © 2018 Emil Karamihov. All rights reserved.
//

import UIKit

class Player: NSObject {
    var Name: String
    var Number: String
    var WinCount: Int
    var id: String!
    var isConnected: Bool!
    
    init(withName:String, withNumber:String, withId: String) {
        self.id = withId
        self.Name = withName
        self.Number = withNumber
        self.WinCount = 0
        self.isConnected = false
    }
    
    override init() {
        self.id = nil
        self.Name = ""
        self.Number = ""
        self.WinCount = 0
        self.isConnected = false
    }
}
