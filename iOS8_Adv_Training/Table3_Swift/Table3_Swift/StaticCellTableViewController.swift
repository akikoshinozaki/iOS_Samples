//
//  StaticCellTableViewController.swift
//  Table3_Swift
//
//  Created by 新居雅行 on 2015/01/28.
//  Copyright (c) 2015年 msyk.net. All rights reserved.
//

import UIKit

class StaticCellTableViewController: UITableViewController {
    
    @IBOutlet private var label1: UILabel?
    @IBOutlet var label2: UILabel?
    @IBOutlet var textField: UITextField?
    @IBOutlet var sw: UISwitch?
    @IBOutlet var progress: UIProgressView?
    @IBOutlet var slider: UISlider?
    
    @IBAction func tapButton1(sender: AnyObject) -> Void {
        label1?.text = textField?.text
    }
    @IBAction func tapButton2(sender: AnyObject) -> Void {
        if let sliderValue = slider?.value {
            label2?.text = NSString(format: "Value=%4.1f", sliderValue)
        }
    }
    @IBAction func changeSlider(sender: AnyObject) -> Void {
        if let sliderValue = slider?.value {
            progress?.progress = sliderValue
        }
    }
    @IBAction func tapSwitch(sender: AnyObject) -> Void {
        if let swObj = sw {
            textField?.text = swObj.on ? "ON" : "OFF"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    /*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // #warning Potentially incomplete method implementation.
    // Return the number of sections.
    println(__FUNCTION__)
    return 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete method implementation.
    // Return the number of rows in the section.
    println(__FUNCTION__)
    return 0
    }
    
    override func tableView(tableView: UITableView,
    cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    println(__FUNCTION__)
    let cell = tableView.dequeueReusableCellWithIdentifier(
    "reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
    
    // Configure the cell...
    
    return cell
    }
    */
    
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