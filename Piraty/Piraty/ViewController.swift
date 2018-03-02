//
//  ViewController.swift
//  Piraty
//
//  Created by Emil Karamihov on 02/03/2018.
//  Copyright © 2018 Emil Karamihov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var pirate:Pirate!
    
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var loc: UILabel!
    @IBOutlet weak var lb: UILabel!
    @IBOutlet weak var bio: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        lb.text = pirate.name
        bio.text = pirate.comments
        year.text = pirate.yearsActive
        loc.text = pirate.countryOfOrigin
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

