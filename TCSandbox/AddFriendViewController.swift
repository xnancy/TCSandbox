//
//  AddFriendViewController.swift
//  TCSandbox
//
//  Created by Nancy Xu on 7/11/16.
//  Copyright © 2016 Nancy Xu. All rights reserved.
//

import Foundation
import UIKit

protocol AddFriendViewControllerDelegate {
    func reloadFriendTable()
}
class AddFriendViewController: UIViewController, UITableViewDataSource, UISearchResultsUpdating, AddFriendViewControllerDelegate {

    /* ---------- TABLE VIEW ---------- */
    @IBOutlet weak var friendSearchTableView: UITableView!
    
    /* ---------- VARIABLES ---------- */
    // Dictionary of all userIDs, corresponding names
    // "120383": "Bob"
    var namesForIDs: NSMutableDictionary!
    
    // List of userIDs in filtered data
    var filteredData: [String]! = []
    
    var searchController: UISearchController!
    
    /* ---------- VIEW CONTROLLER ---------- */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Remove back button bar name
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
        
        // TODO: Fill data array
        
        friendSearchTableView.dataSource = self
        namesForIDs = NSMutableDictionary()
        
        FBClient.generateNonFriendUserIDList(namesForIDs, delegate: self)
        
        // Initializing with searchResultsController set to nil means that
        // searchController will use this view controller to display the search results
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        
        // If we are using this same view controller to present the results
        // dimming it out wouldn't make sense. Should probably only set
        // this to yes if using another controller to display the search results.
        searchController.dimsBackgroundDuringPresentation = false
        
        searchController.searchBar.sizeToFit()
        friendSearchTableView.tableHeaderView = searchController.searchBar
        
        // Initial table data
        filteredData = namesForIDs.allKeys as! [String]
        friendSearchTableView.reloadData()
        
        // Sets this view controller as presenting view controller for the search interface
        definesPresentationContext = true
    }
    
    /* ---------- TABLE VIEW DATA SOURCE ---------- */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = friendSearchTableView.dequeueReusableCellWithIdentifier("searchFriendsTableViewCell") as! searchFriendsTableViewCell
        FBClient.generateFriendSearchCell(filteredData![indexPath.row], cell: cell)
        cell.userID = filteredData![indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filteredData = searchText.isEmpty ? namesForIDs.allKeys as! [String] : (namesForIDs.allKeys as! [String]).filter({(dataString: String) -> Bool in
                return (namesForIDs.valueForKey(dataString) as! String).rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
            })
            friendSearchTableView.reloadData()
        }
    }
    
    /* ---------- DELEGATE ---------- */
    func reloadFriendTable() {
        friendSearchTableView.reloadData()
    }
}
