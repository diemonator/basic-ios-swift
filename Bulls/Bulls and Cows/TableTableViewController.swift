//
//  TableTableViewController.swift
//  Bulls and Cows
//
//  Created by Emil Karamihov on 30/03/2018.
//  Copyright © 2018 Emil Karamihov. All rights reserved.
//

import UIKit


class TableTableViewController: UITableViewController {
    
    var server: Server!
    var dusha: [String]!
    var players: [Player]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addHandlers()
        server.getSocket().emit("connectUser", dusha)
    }
    
    func addHandlers() {
        server.getSocket().on("connectUser") { data, ack in
            if let value = data as? [[String:Any]] {
                self.getPlayers(players: [value[0]])
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCellUser",for: indexPath)
        let i = indexPath.item
        // Configure the cell...
        if (players != nil) {
            cell.textLabel?.text = players![i].Name
        } else {
            cell.textLabel?.text = "Kenny"
        }
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func getPlayers(players: [[String:Any]]) {
            let player = Player()
            for jsonDict in players {
                if let id = jsonDict["id"] as? String {
                    player.id = id
                }
                if let name = jsonDict["name"] as? String {
                    player.Name = name
                }
                if let number = jsonDict["number"] as? String {
                    player.Number = number
                }
                if let connection = jsonDict["isConnected"] as? Bool {
                    player.isConnected = connection
                }
                self.players?.append(player)
            }
        tableView.reloadData()
    }
}
