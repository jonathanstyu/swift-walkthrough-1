//
//  SearchResultsViewController.swift
//  Swift-Walkthrough
//
//  Created by Jonathan Yu on 6/7/14.
//  Copyright (c) 2014 Jonathan Yu. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, APIControllerProtocol {
    @IBOutlet var appsTableView : UITableView
    var tableData: NSArray = NSArray()
    var api: APIController = APIController()
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        api.delegate = self
        api.searchItunesFor("Angry Birds")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
        var rowData: NSDictionary = self.tableData[indexPath.row] as NSDictionary
        
        cell.text = rowData["trackName"] as String
        
        // For image
        var urlString: NSString = rowData["artworkUrl60"] as NSString
        var imgURL: NSURL = NSURL(string: urlString)
        
        // download NSData representation of the image
        var imgData: NSData = NSData(contentsOfURL: imgURL)
        cell.image = UIImage(data: imgData)
        
        var formattedPrice: NSString = rowData["formattedPrice"] as NSString
        cell.detailTextLabel.text = formattedPrice
        
        return cell
    }
    
    func didReceiveAPIResults(results: NSDictionary) {
        println(results)
        // Store the results in an array 
        if results.count > 0 {
            self.tableData = results["results"] as NSArray
            self.appsTableView.reloadData()
        }
    }
    

}

