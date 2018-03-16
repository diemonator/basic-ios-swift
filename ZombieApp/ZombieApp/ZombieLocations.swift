//
//  ZombieLocations.swift
//  ZombieApp
//
//  Created by Emil Karamihov on 09/03/2018.
//  Copyright © 2018 Emil Karamihov. All rights reserved.
//

import UIKit
import MapKit

class ZombieLocations: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: Bool
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: Bool) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }

}
