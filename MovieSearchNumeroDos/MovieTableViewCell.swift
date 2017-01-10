//
//  MovieTableViewCell.swift
//  MovieSearchNumeroDos
//
//  Created by Chandi Abey  on 9/9/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    //MARK:- IB Outlets
    
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
   
    
    //MARK: - Updating Movie Cell

    //this function updates the contents of the tableview cell with the parsed JSON data returned from the movie database API
    func updateMovieCell(movie: Movie) {
        ImageController.imageForURL(movie.imageEndpoint) { (image) in
            //call dispatch whenever we want to go back to the main queue. we just called imagecontroller which took us off the main queue
            dispatch_async(dispatch_get_main_queue(), {
                self.movieNameLabel?.text = movie.title
                self.movieRatingLabel?.text = String(movie.rating)
                self.movieDescriptionLabel?.text = movie.description
                self.moviePoster?.image = image
            })
        }
    }
    
    
}
