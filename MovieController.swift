//
//  MovieController.swift
//  MovieSearchNumeroDos
//
//  Created by Chandi Abey  on 9/9/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import Foundation

class MovieController {
    
    //define URL and URL parameters which will both be included as parameters in the NetworkController performRequest call
    static let baseURL = NSURL(string:"http://api.themoviedb.org/3/search/movie")
    
    
    //make this function static so we dont need a singleton or need to create an instance of moviecontroller in another class to access the fetchmovie function in another file/class
    static func fetchMovie(searchTerm: String, completion: ((movies: [Movie]) -> Void)?) {
        
        let urlParameters = ["query": "\(searchTerm)", "api_key": "cf94204e2c9c89c99eb2506b4b69970a"]
        
        guard let url = baseURL else {
            print("Error: NO URL Found")
            completion?(movies: [])
            return
        }
        
        //make network call to get JSON in NSData form back
        NetworkController.performRequestForURL(url, httpMethod: .Get, urlParameters: urlParameters) { (data, error) in
            
            //unwrap data 
            guard let data = data,
                responseDataString = NSString(data: data, encoding: NSUTF8StringEncoding) else {
                    print("Error: No data returned")
                    completion?(movies: [])
                    return
            }
            
            
            //check if error returned
            if error != nil {
                print(error?.localizedDescription)
                completion?(movies: [])
            } else if responseDataString.containsString("error") {
                print("Error:(\(responseDataString)")
                completion?(movies: [])
            }
            
     
            //if no error and data returned, then serialize the JSON data returned
            guard let jsonAnyObject = try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments),
                      jsonDictionary = jsonAnyObject as? [String: AnyObject],
                      resultsArrayofDictionaries = jsonDictionary["results"] as? [[String: AnyObject]] else {
            print("Error: Unable to serialize returned JSON Data")
            completion?(movies: [])
            return
            }
            
            //go through the array of dictionaries, pull out each dictionary and create a Movie object out of it, put all of these movie objects into an array of movie objects
            let movies = resultsArrayofDictionaries.flatMap{Movie(dictionary: $0)}
            completion?(movies: movies)
            
        }
        
    }
}