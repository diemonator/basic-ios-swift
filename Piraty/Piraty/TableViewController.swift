//
//  TableViewController.swift
//  Piraty
//
//  Created by Emil Karamihov on 02/03/2018.
//  Copyright © 2018 Emil Karamihov. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var pirates = [Pirate]()
    var pirate: Pirate = Pirate.init("GOsgo","GOsgo","GOsgo","GOsgo","GOsgo")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pirates.append(pirate)
        loadJsonData()
        tableView.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btn(_ sender: UIButton) {
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pirates.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let i = indexPath.item
        // Configure the cell...
        cell.textLabel?.text = pirates[i].name
        
        return cell
    }
    
    func parseJsonData(rawData:Any) {
        if let jsonArray = rawData as? [[String:Any]] {
            for jsonDict in jsonArray {
                let newPirate = Pirate()
                if let name = jsonDict["name"] as? String {
                    newPirate.name = name
                }
                if let life = jsonDict["life"] as? String {
                    newPirate.life = life
                }
                if let yearsActive = jsonDict["years_active"] as? String {
                    newPirate.yearsActive = yearsActive
                }
                if let country = jsonDict["country_of_origin"] as? String {
                    newPirate.countryOfOrigin = country
                }
                if let comments = jsonDict["comments"] as? String {
                    newPirate.comments = comments
                }
            pirates.append(newPirate)
            }
        }
        tableView.reloadData()
    }
    
    func loadJsonData() {
        let url = URL(string: "https://i886625.venus.fhict.nl/pirates.json")
        let request = NSURLRequest(url: url! as URL)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in do {
                if (error == nil) {
                    let jsonObject = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                    self.parseJsonData(rawData: jsonObject)
                }
                else {
                    print("Error with http request")
                }
            }
            catch {
                print("Error serializing JSON data")
            }
        }
        dataTask.resume();
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Pirate" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! ViewController
                controller.pirate = pirates[indexPath.row]
            }
        }
    }
}
