//
//  LocationTableViewController.swift
//  Weather App
//
//  Created by Jonathan Thomas on 5/10/16.
//  Copyright © 2016 Jonathan Thomas. All rights reserved.
//

import UIKit

class LocationTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var locations = [Location]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem()
        
        if let savedLocations = loadLocations() {
            locations += savedLocations
        }
        else{}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "LocationTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! LocationTableViewCell

        let location = locations[indexPath.row]

        cell.locationLabel.text = String(location.zipcode)
        cell.tempLabel.text = String(location.Temperature)
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            locations.removeAtIndex(indexPath.row)
            saveLocations()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let locationDetailViewController = segue.destinationViewController as! LocationViewController
            // Get the cell that generated this segue.
            
            if let selectedLocationCell = sender as? LocationTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedLocationCell)!
                let selectedLocation = locations[indexPath.row]
                locationDetailViewController.location = selectedLocation
            }

        }
        else if segue.identifier == "AddItem" {
            print("Adding new Location.")
        }
    }
    

    @IBAction func unwindToLocationList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? LocationViewController, location = sourceViewController.location {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing location.
                locations[selectedIndexPath.row] = location
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }
            else{
                // Add new Location
                let newIndexPath = NSIndexPath(forRow: locations.count, inSection: 0)
                locations.append(location)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            
            // Save the locations.
            saveLocations()
        }
    }
    
    //MARK: NSCoding
    
    func saveLocations() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(locations, toFile: Location.ArchiveURL.path!)
        
        if !isSuccessfulSave {
            print("Failed to save locations...")
        }
    }
    
    func loadLocations() -> [Location]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Location.ArchiveURL.path!) as? [Location]
    }
}
