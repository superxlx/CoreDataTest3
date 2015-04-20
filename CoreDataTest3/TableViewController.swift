//
//  TableViewController.swift
//  CoreDataTest3
//
//  Created by xlx on 15/4/20.
//  Copyright (c) 2015年 xlx. All rights reserved.
//

import UIKit
import CoreData
class TableViewController: UITableViewController {

    @IBOutlet var tableview: UITableView!
    var time:[NSDate!] = []
    var managedContext:NSManagedObjectContext!
    var timearry:TimeArry!
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        managedContext = appDelegate.coreDataStack.context
        var error: NSError?
        let timeFetch = NSFetchRequest(entityName: "TimeArry")
        let result = managedContext.executeFetchRequest(timeFetch, error: &error) as! [TimeArry]!
        if result.count == 0 {
            let entity = NSEntityDescription.entityForName("TimeArry", inManagedObjectContext: managedContext)
            self.timearry = TimeArry(entity: entity!, insertIntoManagedObjectContext: managedContext)
        }else{
            self.timearry=result[0]
        }
        self.time = self.timearry.times.allObjects as [NSdate]
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.timearry.times.count
    }

    @IBAction func addTime(sender: AnyObject) {
        let date=NSDate()
        let entity = NSEntityDescription.entityForName("Time", inManagedObjectContext: managedContext)
        let TimeObject = Time(entity: entity!, insertIntoManagedObjectContext: managedContext)
        TimeObject.time=date
       
        //Insert the new times into the TimeArry's times set
        var times = timearry.times.mutableCopy() as! NSMutableSet
        times.addObject(TimeObject)
        timearry.times = times.copy() as! NSSet
        
        //Save the managed object context
        var error: NSError?
        if !managedContext!.save(&error) {
            println("Could not save: \(error)")
        }
        
        
        self.tableview.reloadData()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell

        var fmt=NSDateFormatter()
        fmt.dateFormat = "yyyy-MM-dd-hh-mm-ss"
   //     let date = self.timearry.times.member(indexPath.row) as! Time
      //      println(self.timearry.times)
  //      let showtime = fmt.stringFromDate(date.time)
        
        cell.textLabel!.text = "1"

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
