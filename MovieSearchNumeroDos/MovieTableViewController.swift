//
//  MovieTableViewController.swift
//  MovieSearchNumeroDos
//
//  Created by Chandi Abey  on 9/9/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController, UISearchBarDelegate {

    //MARK: - IB Outlet
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    //MARK: - ViewDidLoad function, assign the search bar delegate to the tableview
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    //initialize an empty array to hold the movie objects returned from the API call. Use didSet to observe the movies array each time there is a change and reload the table view
    var movies: [Movie] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    

    //MARK: - Search Bar Delegate
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        //pull the searchTerm text out of the search Bar and assign it as the value of the searchTerm parameter in fetchMovie function
        guard let searchTerm = searchBar.text else { return }
        
        //make the API call the moment the user clicks the searchbarbutton
        MovieController.fetchMovie(searchTerm) { (movies) in
            //since we made a call to the fetchMovie function, we were pulled to the back thread. Pull us back to the main thread by calling the dispatch_async function.
            
             dispatch_async(dispatch_get_main_queue(), {
            
               //assign the movies returned from the fetchMovie function to the empty movies array we created up above
                self.movies = movies
                //make the keyboard go away
                self.resignFirstResponder()
            })
        }
    }

   
    // MARK: - Table view data source functions


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    //remember to update cell identifier name and cast as custom cell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("movieCell", forIndexPath: indexPath) as? MovieTableViewCell
        //pull an individual movie object out of the movies array to populate each cell
        let movie = movies[indexPath.row]
        // call update cell function and include movie as parameter
        cell?.updateMovieCell(movie)
        return cell ?? MovieTableViewCell()
    }
   

    
}
