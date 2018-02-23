//
//  WorstViewController.swift
//  TheWorstMovieApp
//
//  Created by Emil Karamihov on 23/02/2018.
//  Copyright © 2018 Emil Karamihov. All rights reserved.
//

import UIKit

class WorstViewController: UIViewController {
    var counter = 1
    let alert = UIAlertController(title: "Segue", message: "FromViewDidLoad.", preferredStyle: .alert)
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func click(_ sender: UIButton) {
        text.text = "Clicked one time click again? to go back"
        sender.setTitle("Goes Back now with Segue", for: .normal)
        if counter == 2 {
            performSegue(withIdentifier: "Back", sender: nil)
        }
        counter+=1
    }
}
