//
//  NutritionAPI.swift
//  Kitchen Calculator
//
//  Created by Tommy Bojanin on 7/3/18.
//  Copyright © 2018 Tommy Bojanin. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

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
    private static func searchItemsURL(itemToSearch str: String, page : String = "0") -> URL {
        var components = URLComponents(string: apiURL)!
        var queryItems = [URLQueryItem]()
        
        let params: [String : String] = ["json" : SearchParameters.search.rawValue,
                                         "q" : str,
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
    
    static func searchItems(itemToSearch keyword: String, completion: @escaping (ItemList?, Error?) ->()) {
        
        let url = NutritionAPI.searchItemsURL(itemToSearch: keyword)
        
        
        request(url).responseJSON {response in
            
            //Acquire list of food items data
            if let data = response.data {
                //Construct the object
                if let itemList = ItemList(jsonObject: JSON(data)) {
                    completion(itemList, nil)
                } else {
                    completion(nil, FoodError.invalidJSON)
                }
            }
            
        }
        
        
    }
    
    static func getFoodItem (withBarcode barcode:String, completion: @escaping (Food?, Error?) -> ()) {
        
        let url = NutritionAPI.foodItemURL(barcode: barcode)
        
        
        request(url).responseJSON { (response) in
            
            //Acquire the JSON data.
            if let data = response.data {
                
                //Construct food object from the data.
                if let food = Food(json: JSON(data)){
                    completion(food, nil)
                } else {
                    
                    completion(nil, FoodError.invalidJSON)
                }
            }
        }
    }
}
