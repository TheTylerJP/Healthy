//
//  Food.swift
//  Kitchen Calculator
//
//  Created by Tommy Bojanin on 3/6/18.
//  Copyright © 2018 Tommy Bojanin. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire



public enum FoodError: Error {
    case invalidJSON
}



class Food{
    let productId:String
    let title:String
    let description:String
    let imageURL:String
    let price:String
    
    let properties:JSON
    let healthnotes:String
    let weight:String
    
    init?(json:JSON) {
        self.productId = json["productId"].stringValue
        self.title = json["title"].stringValue
        self.description = json["description"].stringValue
        self.imageURL = json["image"].stringValue
        self.price = json["price"].stringValue
        self.properties = json["properties"]
        self.healthnotes = json["healthnotes"].stringValue
        self.weight = json["weight"].stringValue
    }
    

    static func getFoodItem (barcode:String, completion: @escaping (Food?, Error?) -> ()) {
        
        let url : URL = NutritionAPI.foodItemURL(barcode: barcode)
        

        request(url).responseJSON { (response) in
            if let data = response.data {
                
                if let food = Food(json: JSON(data)){
                    print(food)
                    completion(food, nil)
                } else {
                    
                    completion(nil, FoodError.invalidJSON)
                }
            }
        }
    }
        
    
    
}
