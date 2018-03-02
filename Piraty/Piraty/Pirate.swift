//
//  Pirate.swift
//  Piraty
//
//  Created by Emil Karamihov on 02/03/2018.
//  Copyright © 2018 Emil Karamihov. All rights reserved.
//

import UIKit

class Pirate: NSObject {
    var name, life, yearsActive, countryOfOrigin, comments:String!
    init(_ name: String,_ life: String,_ yearsActive: String,_ countryOfOrigin: String,_ comments:String ) {
        self.name = name
        self.life = life
        self.yearsActive = yearsActive
        self.countryOfOrigin = countryOfOrigin
        self.comments = comments
    }
    
    override init()
    {
        self.name = ""
        self.life = ""
        self.yearsActive = ""
        self.countryOfOrigin = ""
        self.comments = ""
    }
}
