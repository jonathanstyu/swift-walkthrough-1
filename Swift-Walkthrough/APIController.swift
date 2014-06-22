//
//  APIController.swift
//  Swift-Walkthrough
//
//  Created by Jonathan Yu on 6/21/14.
//  Copyright (c) 2014 Jonathan Yu. All rights reserved.
//

import UIKit

protocol APIControllerProtocol {
    func didReceiveAPIResults(results: NSDictionary)
}

class APIController: NSObject {
    var delegate: APIControllerProtocol?
    var data: NSMutableData = NSMutableData()
    
    func searchItunesFor(searchTerm: String) {
        var iTunesSearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        
        // escape anything that is not URL friendly
        var escapedSearchTerm = iTunesSearchTerm.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        var urlPath = "https://itunes.apple.com/search?term=\(escapedSearchTerm)&media=software"
        var url = NSURL(string: urlPath)
        var request: NSURLRequest = NSURLRequest(URL: url)
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)
        
        println("Search iTunes API for URL \(url)")
        connection.start()
    }
    
    func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
        self.data = NSMutableData()
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
        // Append the received data to data object
        self.data.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        // Request complete. self.data should have the information
        // Convert the retrieved data into an object through JSON deserialization
        
        var err: NSError
        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary

        self.delegate?.didReceiveAPIResults(jsonResult)
        
    }

}
