//
//  ImageController.swift
//  MovieSearchNumeroDos
//
//  Created by Chandi Abey  on 9/9/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import Foundation
import UIKit

//creating this b/c image we get back is a string and we need the actual image
class ImageController {
    
    
    static let baseURL = NSURL(string: "http://image.tmdb.org/t/p/w500/")
    
    
    static func imageForURL(imageEndpoint: String, completion: ((image: UIImage?)-> Void)) {
        let endpoint = baseURL?.URLByAppendingPathComponent("\(imageEndpoint)")
        
        //without guard statement, it would be an optional NSURL
        guard let url = endpoint else { fatalError("Image URL optional is nil") }
        
        //call network controller and use the second performrequest
        NetworkController.performRequestForURL(url, httpMethod: .Get) { (data, error) in
            
            
            guard let data = data else {  completion(image: nil); return }
            dispatch_async(dispatch_get_main_queue(), {
                
                //throw in data and returns optional UIImage
                completion(image: UIImage(data: data))
                
            })
        }
        
    }
}