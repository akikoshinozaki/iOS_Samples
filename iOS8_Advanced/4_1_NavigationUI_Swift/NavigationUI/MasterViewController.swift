//
//  MasterViewController.swift
//  2_1_NavigationUI
//
//  Created by 新居雅行 on 2014/07/15.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    
    var detailViewController: DetailViewController? = nil
    var objects = NSMutableArray()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println(__FUNCTION__, __LINE__)
        var horizontal, vertical: String
        switch self.view.traitCollection.horizontalSizeClass {
        case .Unspecified:  horizontal = "Unspecified"
        case .Compact:  horizontal = "Compact"
        case .Regular:  horizontal = "Regular"
        }
        switch self.view.traitCollection.verticalSizeClass {
        case .Unspecified:  vertical = "Unspecified"
        case .Compact:  vertical = "Compact"
        case .Regular:  vertical = "Regular"
        }
        println("Size Classes:\(horizontal)#\(vertical)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func insertNewObject(sender: AnyObject) {
        objects.insertObject(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    // #pragma mark - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let tappedCell = sender as! UITableViewCell
            if let indexPath = self.tableView.indexPathForCell(tappedCell) {
                let object = objects[indexPath.row] as! NSDate
                let destNC = segue.destinationViewController as! UINavigationController
                let destVC = destNC.topViewController as! DetailViewController
                destVC.navigationItem.title = object.description
            }
        }
    }
    
    // #pragma mark - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        let object = objects[indexPath.row] as! NSDate
        cell.textLabel!.text = object.description
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            let object = objects[indexPath.row] as! NSDate
            self.detailViewController!.detailItem = object
        }
    }
    
    
}

