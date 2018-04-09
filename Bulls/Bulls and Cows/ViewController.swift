//
//  ViewController.swift
//  Bulls and Cows
//
//  Created by Emil Karamihov on 29/03/2018.
//  Copyright © 2018 Emil Karamihov. All rights reserved.
//
import SocketIO
import UIKit


class ViewController: UIViewController {
    var playerItems: [String]!
    var server: Server = Server()
    @IBOutlet weak var tbName: UITextField!
    @IBOutlet weak var tbNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        server.connect()
    }

    @IBAction func BtnCreateGame(_ sender: UIButton) {
        if (tbNumber.text?.count == 4 && checkInput() && (tbName.text?.count)! > 0) {
            playerItems = [tbName.text!, tbNumber.text!]
            performSegue(withIdentifier: "Next", sender: self)
        } else {
            let alert = UIAlertController(title: "Warring?", message: "No repearts in your 4 digit suggestion number", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func checkInput()-> Bool{
        var check = Array(tbNumber.text!)
        for i in 0...tbNumber.text!.count-1 {
            for j in 0...check.count-1 {
                if (i != j){
                    if (check[i] == check[j]){
                        return false
                    }
                }
            }
        }
        return true
    }
        
    @IBAction func BtnClicked(_ sender: UIButton) {
        playerItems = [tbName.text!, tbNumber.text!]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is GameViewController {
            let vc = segue.destination as? GameViewController
            vc?.server = self.server
            vc?.serverPlayer = self.playerItems
        } else if (segue.destination is TableTableViewController) {
            let vc = segue.destination as? TableTableViewController
            vc?.server = self.server
            vc?.dusha = self.playerItems
        }
    }
}

