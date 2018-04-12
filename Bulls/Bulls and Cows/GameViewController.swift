//
//  GameViewController.swift
//  Bulls and Cows
//
//  Created by Emil Karamihov on 30/03/2018.
//  Copyright © 2018 Emil Karamihov. All rights reserved.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController {
    
    var player: AVAudioPlayer?
    var server: Server!
    var serverPlayer: [String]!
    var myTurn: Bool!
    var win = "win"
    
    @IBOutlet weak var tbSuggestion: UITextField!
    @IBOutlet weak var tfInfo: UITextView!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var otherPlayerStats: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addHandlers()
        server.getSocket().emit("connectUser", serverPlayer)
        server.getSocket().emit("setPlayers", serverPlayer)
        disable()
    }
    
    private func addHandlers() {
        server.getSocket().on("setPlayers") { [weak self] data, ack in
            if let value = data.first as? Bool {
                self?.checkIfFirst(param: value)
            }
        }
        server.getSocket().on("connectUser") { [weak self] data, ack in
            self?.serverPlayer = data.first as? [String]
        }
        server!.getSocket().on("getSuggestion") { [weak self] data, ack in
            if let value = data.first as? String {
                if (value.range(of: self!.win) != nil ) {
                    self!.btn.setTitle("New Game", for: .normal)
                    self!.checkIfFirst(param: true)
                    self!.playSound(param: self!.win)
                }
                if (value.range(of: self!.serverPlayer[0]) != nil) {
                    self?.tfInfo.text.append(value)
                } else {
                    self?.otherPlayerStats.text.append(value)
                }
            }
        }
        server.getSocket().on("rounds") { [weak self] data, ack in
            if let value = data.first as? Bool {
                self?.myTurn = value
                self?.checkIfFirst(param: (self?.myTurn)!)
            }
        }
        server.getSocket().on("exitUser") { data, ack in
            print("Exiting")
        }
    }
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        if (btn.titleLabel?.text != "New Game") {
            if (Checker.checkInput(number: tbSuggestion.text!)) {
                server.getSocket().emit("getSuggestion", tbSuggestion.text!)
                tbSuggestion.text = nil
                playSound(param: "stairs")
                disable()
                server.getSocket().emit("rounds", myTurn)
            } else {
                let alert = UIAlertController(title: "Warring?", message: "No repearts in your 4 digit suggestion number", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        } else {
            performSegue(withIdentifier: "Back", sender: self)
            server.getSocket().emit("exitUser", serverPlayer)
            server.disconnect()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func checkIfFirst(param: Bool) {
        if (param == true) {
            btn.isUserInteractionEnabled = true
            btn.isEnabled = true
        }
        myTurn = param
    }
    
    private func disable() {
        btn.isUserInteractionEnabled = false
        btn.isEnabled = false
    }
    
    private func playSound(param: String) {
        guard let url = Bundle.main.url(forResource: param, withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
