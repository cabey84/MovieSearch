//
//  Movie.swift
//  MovieSearchNumeroDos
//
//  Created by Chandi Abey  on 9/9/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import Foundation

class Movie {
    
    //keys to use in failable initializer, keys are from movie database API json 
    private let kTitle = "title"
    private let kRating = "vote_average"
    private let kDescription = "overview"
    private let kPoster = "poster_path"
    
    //movie properties
    let title: String
    let rating: Float
    let description: String
    let imageEndpoint: String
    
    //failable initializer to be used to create movie object from parsed JSON returned
    init?(dictionary: [String: AnyObject]) {
        guard let title = dictionary[kTitle] as? String,
                  rating = dictionary[kRating] as? Float,
                  description = dictionary[kDescription] as? String,
                  imageEndpoint = dictionary[kPoster] as? String
        else { return nil }
        self.title = title
        self.rating = rating
        self.description = description
        self.imageEndpoint = imageEndpoint
    }
    
}