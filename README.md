swift-walkthrough-1
===================

My first taste of Swift. Trying to get a handle on it. 

## Part I

Part I of this Walkthrough has you just setting up a simple TableView and populating it with some static numbers. That went by relatively easily. 

## Part II

The second part though was more difficult. You had to access an iTunes API and do a query. You would then populate the cells with some of the results.

You first created an NSURL from a string text interpolated with your query. With that NSURL you create an NSURLConnection which would make a request from iTunes with your URL. You receive a response and then append it with appendData() into a broad NSData variable called self.data. 

Then I convert the serialized data from a JSON into a NSDictionary and then into an NSArray. I take the various parts of the array and use it to populate the table. 

Had issues at first a weird Optional null value. Turns out I had not connected a variable I was calling in the View Controller to the table in the Storyboard file. Found the answer in the comments of the walkthrough which is good because that was a very generic error message I was getting. 
