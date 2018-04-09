//
//  CredentalsViewController.swift
//  Bulls and Cows
//
//  Created by Emil Karamihov on 30/03/2018.
//  Copyright © 2018 Emil Karamihov. All rights reserved.
//

import UIKit
import SocketIO

class CredentalsViewController: UIViewController {
    @IBOutlet weak var tbName: UITextField!
    @IBOutlet weak var tbNumber: UITextField!
    var socket: SocketIOClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnPlay(_ sender: UIButton) {
        let info:  [String] = [tbName.text!,tbNumber.text!]
        socket.emit("playerInfo", info)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is GameViewController {
            let vc = segue.destination as? GameViewController
            vc!.socket = socket
        }
    }
}

