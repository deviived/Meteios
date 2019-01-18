//
//  myListTableViewController.swift
//  Pongios
//
//  Created by budo on 17/01/2019.
//  Copyright © 2019 PACHECO Luc. All rights reserved.
//

import UIKit

class myListTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var data: [String: String]?
    var image: UIImage?
    let WEATHER_IMG = [
        "Rain": "rainy.png",
        "Clouds": "cloud.png",
        "Thunderstorm": "lightning.png",
        "Snow": "snow.png",
        "Drizzle": "misty.png"
    ]
    let LANG_FR = [
        "Monday": "Lundi",
        "Tuesday": "Mardi",
        "Wesnesday": "Mercredi",
        "Thursday": "Jeudi",
        "Friday": "Vendredi",
        "Saturday": "Samedi",
        "Sunday": "Dimanche"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = MeteoService.getForecast(long: 1, lat: 2)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }*/
    

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data?.count ?? 0
    }

    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*guard let cell = tableView.dequeueReusableCell(withIdentifier: "smogo", for: indexPath) as? Example1Cell
            
        else{
            fatalError("ERROR SYSTEM!!!!")
        }
        */
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "smogo")
        var i = 0
        for (key, value) in data! {
            if indexPath.row == i {
                if let weather_item = value as? String {
                    var imgName = "summer.png"
                    if let _ = self.WEATHER_IMG[weather_item] {
                        imgName = self.WEATHER_IMG[weather_item]!
                    }
                    self.image = UIImage(named: imgName)
                    cell.imageView?.image = self.image
                    
                }
                cell.textLabel?.text = "\(key)"
            }
            i = i + 1
        }
        print(indexPath)
        //cell.textLabel?.text = data[]
        // Configure the cell...

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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class Example1Cell: UITableViewCell {
    
}
