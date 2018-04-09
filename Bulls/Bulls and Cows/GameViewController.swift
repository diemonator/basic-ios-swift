//
//  GameViewController.swift
//  Bulls and Cows
//
//  Created by Emil Karamihov on 30/03/2018.
//  Copyright © 2018 Emil Karamihov. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var server: Server!
    var serverPlayer: [String]!
    var myTurn: Bool!
    
    @IBOutlet weak var tbSuggestion: UITextField!
    @IBOutlet weak var tfInfo: UITextView!
    @IBOutlet weak var btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addHandlers()
        server.getSocket().emit("connectUser", serverPlayer)
        server.getSocket().emit("setPlayers", serverPlayer)
        btn.isUserInteractionEnabled = false
        btn.isEnabled = false
    }
    
    func addHandlers() {
        server.getSocket().on("setPlayers") { [weak self] data, ack in
            if let value = data[0] as? Bool {
                self?.checkIfFirst(param: value)
            }
        }
        server.getSocket().on("connectUser") { [weak self] data, ack in
            self?.serverPlayer = data.first as? [String]
        }
        server!.getSocket().on("getSuggestion") { [weak self] data, ack in
            if let value = data.first as? String {
                self?.tfInfo.text.append(value)
            }
        }
        server.getSocket().on("rounds") { [weak self] data, ack in
            if let value = data.first as? Bool {
                self?.myTurn = value
                self?.checkIfFirst(param: (self?.myTurn)!)
            }
        }
    }
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        if (tbSuggestion.text?.count == 4 && checkInput()) {
            server.getSocket().emit("getSuggestion", tbSuggestion.text!)
            tbSuggestion.text = nil
            btn.isUserInteractionEnabled = false
            btn.isEnabled = false
            server.getSocket().emit("rounds", myTurn)
        } else {
            let alert = UIAlertController(title: "Warring?", message: "No repearts in your 4 digit suggestion number", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func checkInput()-> Bool{
        var check = Array(tbSuggestion.text!)
        for i in 0...tbSuggestion.text!.count-1 {
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        server.disconnect()
    }
    
    func checkIfFirst(param: Bool) {
        if (param == true) {
            btn.isUserInteractionEnabled = true
            btn.isEnabled = true
        }
        myTurn = param
    }
    
}
