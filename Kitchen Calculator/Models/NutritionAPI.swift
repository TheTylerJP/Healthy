//
//  NutritionAPI.swift
//  Kitchen Calculator
//
//  Created by Tommy Bojanin on 7/3/18.
//  Copyright © 2018 Tommy Bojanin. All rights reserved.
//

import Foundation

struct NutritionAPI {
    fileprivate static let apiKey : String = "bAABebg8UDkbCsGXka4F"
    fileprivate static let apiURL  : String = "http://supermarketownbrandguide.co.uk/api/newfeed.php"
    
    private enum SearchParameters : String {
        case search
        case barcode
    }
    
    
    
    //Function to create URL for grabbing a single food item
      static func foodItemURL(barcode : String) -> URL {
        var components = URLComponents(string: apiURL)!
        var queryItems = [URLQueryItem]()
        
        let params: [String : String] = ["json" : SearchParameters.barcode.rawValue,
                                         "q" : barcode,
                                         "apikey" : apiKey
        ]
        
        for (key, value) in params {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        components.queryItems = queryItems
        
        print("URL: \(String(describing: components.url)) ")
        
        return components.url!
    }
    
    //Function to create uRL for creating a list of items.
    private static func searchItemsURL(searchString  : String, page : String = "0") -> URL {
        var components = URLComponents(string: apiURL)!
        var queryItems = [URLQueryItem]()
        
        let params: [String : String] = ["json" : SearchParameters.search.rawValue,
                                         "q" : searchString,
                                         "page" : page,
                                         "apikey" : apiKey
        ]
        
        for (key, value) in params {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        components.queryItems = queryItems
        
        print("URL: \(String(describing: components.url)) ")
        
        return components.url!
    }
}
